#version 120

#include "distort.glsl"

varying vec2 TexCoords;

// Direction of the sun (not normalized!)
uniform vec3 sunPosition;

// The color textures which we wrote to
uniform sampler2D colortex0;
uniform sampler2D colortex1;
uniform sampler2D colortex2;
uniform sampler2D depthtex0;
uniform sampler2D shadowtex0;
uniform sampler2D shadowtex1;
uniform sampler2D shadowcolor0;
uniform sampler2D noisetex;

uniform mat4 gbufferProjectionInverse;
uniform mat4 gbufferModelViewInverse;
uniform mat4 shadowModelView;
uniform mat4 shadowProjection;

/*
const int colortex0Format = RGBA16F;
const int colortex1Format = R11F_G11F_B10F;
const int colortex2Format = R11F_G11F_B10F;
const int colortex3Format = R11F_G11F_B10F;
*/

#define COLORED_SHADOWS 1 // [0 1]
const float sunPathRotation = -40.0; // [60.0 50.0 40.0 30.0 20.0 10.0 0.0 -10.0 -20.0 -30.0 -40.0 -50.0 -60.0]
const int shadowMapResolution = 2048; // [256 512 1024 2048 4096 8192 16384]
const int noiseTextureResolution = 64; // [8 16 32 64 128 256 512]

const float Ambient = 0.025f;

float AdjustLightmapTorch(in float torch) {
    const float K = 2.0f;
    const float P = 5.06f;
    return K * pow(torch, P);
}

float AdjustLightmapSky(in float sky){
    float sky_2 = sky * sky;
    return sky_2 * sky_2;
}

vec2 AdjustLightmap(in vec2 Lightmap){
    vec2 NewLightMap;
    NewLightMap.x = AdjustLightmapTorch(Lightmap.x);
    NewLightMap.y = AdjustLightmapSky(Lightmap.y);
    return NewLightMap;
}

// Input is not adjusted lightmap coordinates
vec3 GetLightmapColor(in vec2 Lightmap){
    // First adjust the lightmap
    Lightmap = AdjustLightmap(Lightmap);
    // Color of the torch and sky. The sky color changes depending on time of day but I will ignore that for simplicity
    const vec3 TorchColor = vec3(1.0f, 0.25f, 0.08f);
    const vec3 SkyColor = vec3(0.05f, 0.15f, 0.3f);
    // Multiply each part of the light map with it's color
    vec3 TorchLighting = Lightmap.x * TorchColor;
    vec3 SkyLighting = Lightmap.y * SkyColor;
    // Add the lighting togther to get the total contribution of the lightmap the final color.
    vec3 LightmapLighting = TorchLighting + SkyLighting;
    // Return the value
    return LightmapLighting;
}

float Visibility(in sampler2D ShadowMap, in vec3 SampleCoords) {
    return step(SampleCoords.z - 0.001f, texture2D(ShadowMap, SampleCoords.xy).r);
}

vec3 TransparentShadow(in vec3 SampleCoords){
    float ShadowVisibility0 = Visibility(shadowtex0, SampleCoords);
    float ShadowVisibility1 = Visibility(shadowtex1, SampleCoords);
    #if COLORED_SHADOWS == 0
        vec4 ShadowColor0 = vec4(1f, 1f, 1f, 0.5f);
    #else
        vec4 ShadowColor0 = texture2D(shadowcolor0, SampleCoords.xy);
    #endif
    vec3 TransmittedColor = ShadowColor0.rgb * (1.0f - ShadowColor0.a); // Perform a blend operation with the sun color
    return mix(TransmittedColor * ShadowVisibility1, vec3(1.0f), ShadowVisibility0);
}

#define SHADOW_SAMPLES 2 // [1 2 3 4 5 6 7 8]
#define SHADOW_NOISING 1 // [0 1]
const int ShadowSamplesPerSize = 2 * SHADOW_SAMPLES + 1;
const int TotalSamples = ShadowSamplesPerSize * ShadowSamplesPerSize;

vec3 GetShadow(float depth) {
    vec3 ClipSpace = vec3(TexCoords, depth) * 2.0f - 1.0f;
    vec4 ViewW = gbufferProjectionInverse * vec4(ClipSpace, 1.0f);
    vec3 View = ViewW.xyz / ViewW.w;
    vec4 World = gbufferModelViewInverse * vec4(View, 1.0f);
    vec4 ShadowSpace = shadowProjection * shadowModelView * World;
    ShadowSpace.xy = DistortPosition(ShadowSpace.xy - 0.0002f);
    vec3 SampleCoords = ShadowSpace.xyz * 0.5f + 0.5f;
    #if SHADOW_NOISING == 1
        float RandomAngle = texture2D(noisetex, TexCoords * 10.0f).r * 100.0f;
    #else
        float RandomAngle = texture2D(noisetex, TexCoords * 0.0f).r * 100.0f;
    #endif
    float cosTheta = cos(RandomAngle);
	float sinTheta = sin(RandomAngle);
    mat2 Rotation =  mat2(cosTheta, -sinTheta, sinTheta, cosTheta) / shadowMapResolution; // We can move our division by the shadow map resolution here for a small speedup
    vec3 ShadowAccum = vec3(0.0f);
    for(int x = -SHADOW_SAMPLES; x <= SHADOW_SAMPLES; x++){
        for(int y = -SHADOW_SAMPLES; y <= SHADOW_SAMPLES; y++){
            vec2 Offset = Rotation * vec2(x, y);
            vec3 CurrentSampleCoordinate = vec3(SampleCoords.xy + Offset + 0.00015, SampleCoords.z + 0.00065);
            ShadowAccum += TransparentShadow(CurrentSampleCoordinate);
        }
    }
    ShadowAccum /= TotalSamples;
    return ShadowAccum;
}

#define DEFERREDVAL 0 // [0 1]

void main(){
    // Account for gamma correction
    vec3 Albedo = pow(texture2D(colortex0, TexCoords).rgb, vec3(2.0f));
    float Depth = texture2D(depthtex0, TexCoords).r;
    if(Depth == 1.0f){
        gl_FragData[0] = vec4(Albedo, 1.0f);
        return;
    }
    // Get the normal
    vec3 Normal = normalize(texture2D(colortex1, TexCoords).rgb * 2.0f - 1.0f);
    // Get the lightmap
    vec2 Lightmap = texture2D(colortex2, TexCoords).rg;
    vec3 LightmapColor = GetLightmapColor(Lightmap);
    // Compute cos theta between the normal and sun directions
    float NdotL = max(dot(Normal, normalize(sunPosition)), 0.15f);
    // Do the lighting calculations
    vec3 Diffuse = Albedo * (LightmapColor + NdotL * GetShadow(Depth) + Ambient);
    /* DRAWBUFFERS:0123 */
    // Finally write the diffuse color
    gl_FragData[0] = vec4(Diffuse, 1.0f);
}