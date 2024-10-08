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
const float sunPathRotation = 40.0; // [60.0 50.0 40.0 30.0 20.0 10.0 0.0 -10.0 -20.0 -30.0 -40.0 -50.0 -60.0]
const int shadowMapResolution = 2048; // [256 512 1024 2048 4096 8192 16384]
const int noiseTextureResolution = 8; // [8 16 32 64 128 256 512]

const float Ambient = 0.025f;
const float C = 360.0f; // Exponential shadow map constant

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
    // Add the lighting together to get the total contribution of the lightmap the final color.
    vec3 LightmapLighting = TorchLighting + SkyLighting;
    // Return the value
    return LightmapLighting;
}

float ESMShadowVisibility(sampler2D shadowMap, vec3 sampleCoords) {
    float depth = texture2D(shadowMap, sampleCoords.xy).r;
    return exp(-C * max(0.0, sampleCoords.z - depth));
}

vec3 TransparentShadow(vec3 sampleCoords){
    float shadowVisibility0 = ESMShadowVisibility(shadowtex0, sampleCoords);
    float shadowVisibility1 = ESMShadowVisibility(shadowtex1, sampleCoords);
    #if COLORED_SHADOWS == 0
        vec4 shadowColor0 = vec4(1.0, 1.0, 1.0, 0.5);
    #else
        vec4 shadowColor0 = texture2D(shadowcolor0, sampleCoords.xy);
    #endif
    vec3 transmittedColor = shadowColor0.rgb * (1.0 - shadowColor0.a); // Perform a blend operation with the sun color
    return mix(transmittedColor * shadowVisibility1, vec3(1.0), shadowVisibility0);
}

#define SHADOW_SAMPLES 2 // [1 2 3 4 5 6 7 8]
#define SHADOW_NOISING 1 // [0 1]

vec3 GetShadow(float depth) {
    vec3 clipSpace = vec3(TexCoords, depth) * 2.0 - 1.0;
    vec4 viewW = gbufferProjectionInverse * vec4(clipSpace, 1.0);
    vec3 view = viewW.xyz / viewW.w;
    vec4 world = gbufferModelViewInverse * vec4(view, 1.0);
    vec4 shadowSpace = shadowProjection * shadowModelView * world;
    shadowSpace.xy = DistortPosition(shadowSpace.xy - 0.0002);
    vec3 sampleCoords = shadowSpace.xyz * 0.5 + 0.5;

    float randomAngle;
    #if SHADOW_NOISING == 1
        randomAngle = texture2D(noisetex, TexCoords * 10.0).r * 100.0;
    #else
        randomAngle = texture2D(noisetex, TexCoords * 0.0).r * 100.0;
    #endif
    float cosTheta = cos(randomAngle);
    float sinTheta = sin(randomAngle);
    mat2 rotation = mat2(cosTheta, -sinTheta, sinTheta, cosTheta) / shadowMapResolution;

    vec3 shadowAccum = vec3(0.0);
    for (int x = -SHADOW_SAMPLES; x <= SHADOW_SAMPLES; x++) {
        for (int y = -SHADOW_SAMPLES; y <= SHADOW_SAMPLES; y++) {
            vec2 offset = rotation * vec2(x, y);
            vec3 currentSampleCoordinate = vec3(sampleCoords.xy + offset, sampleCoords.z);
            shadowAccum += TransparentShadow(currentSampleCoordinate);
        }
    }
    shadowAccum /= (2 * SHADOW_SAMPLES + 1) * (2 * SHADOW_SAMPLES + 1);
    return shadowAccum;
}

#define DEFERREDVAL 0 // [0 1 2]

void main(){
    // Account for gamma correction
    vec3 albedo = pow(texture2D(colortex0, TexCoords).rgb, vec3(2.0));
    float depth = texture2D(depthtex0, TexCoords).r;
    if(depth == 1.0){
        gl_FragData[0] = vec4(albedo, 1.0);
        return;
    }
    // Get the normal
    vec3 normal = normalize(texture2D(colortex1, TexCoords).rgb * 2.0 - 1.0);
    // Get the lightmap
    vec2 lightmap = texture2D(colortex2, TexCoords).rg;
    vec3 lightmapColor = GetLightmapColor(lightmap);
    // Compute cos theta between the normal and sun directions
    float NdotL = max(dot(normal, normalize(sunPosition)), 0.15);
    // Do the lighting calculations
    vec3 diffuse = albedo * (lightmapColor + NdotL * GetShadow(depth) + Ambient);
    /* DRAWBUFFERS:0123 */
    // Finally write the diffuse color
    gl_FragData[0] = vec4(diffuse, 1.0);
}
