#ifndef SHADOW_GLSL
#define SHADOW_GLSL

uniform mat4 gbufferProjectionInverse;
uniform mat4 gbufferModelViewInverse;
uniform mat4 shadowModelView;
uniform mat4 shadowProjection;

uniform sampler2D depthtex0;
uniform sampler2D shadowtex0;
uniform sampler2D shadowtex1;
uniform sampler2D shadowcolor0;

float PCFShadowVisibility(sampler2D shadowMap, vec3 sampleCoords, int sampleRadius) 
{
  float shadow = 0.0;
  vec2 texelSize = 1.0 / vec2(textureSize(shadowMap, 0));
  for(int x = -sampleRadius; x <= sampleRadius; ++x) {
    for(int y = -sampleRadius; y <= sampleRadius; ++y) {
      vec2 offset = vec2(x, y) * texelSize;
      float depth = texture(shadowMap, sampleCoords.xy + offset).r;
      if(depth < sampleCoords.z) {
        shadow += 1.0;
      }
    }
  }
  int totalSamples = (2 * sampleRadius + 1) * (2 * sampleRadius + 1);
  return clamp(1.0 - (shadow / float(totalSamples)), 0.0, 1.0);
}

vec3 TransparentShadow(vec3 sampleCoords, int sampleRadius)
{
  float shadowVisibility0 = PCFShadowVisibility(shadowtex0, sampleCoords, sampleRadius);
  float shadowVisibility1 = PCFShadowVisibility(shadowtex1, sampleCoords, sampleRadius);

  vec4 shadowColor0 = texture(shadowcolor0, sampleCoords.xy);
  
  vec3 transmittedColor = shadowColor0.rgb * (1.0 - shadowColor0.a);
  return mix(transmittedColor * shadowVisibility1, vec3(1.0), shadowVisibility0);
}

vec3 GetShadow(float depth, int sampleRadius, vec2 TexCoord)
{
  vec3 clipSpace = vec3(TexCoord, depth) * 2.0 - 1.0;
  vec4 viewW = gbufferProjectionInverse * vec4(clipSpace, 1.0);
  vec3 view = viewW.xyz / viewW.w;
  vec4 world = gbufferModelViewInverse * vec4(view, 1.0);
  vec4 shadowSpace = shadowProjection * shadowModelView * world;
  shadowSpace.xy = DistortPosition(shadowSpace.xy);
  vec3 sampleCoords = shadowSpace.xyz * 0.5 + 0.5;

  return TransparentShadow(sampleCoords, sampleRadius);
}

#endif
