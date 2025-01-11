#version 330 compatibility

#include "/lib/distort.glsl"
#include "/lib/albedo.glsl"
#include "/lib/lightmap.glsl"
#include "/lib/shadow.glsl"

in vec2 TexCoord;

uniform vec3 shadowLightPosition;

uniform sampler2D colortex0;
uniform sampler2D colortex1;
uniform sampler2D colortex2;

/* RENDERTARGET: 0 */
layout(location = 0) out vec4 diffuse;

const float Ambient = 0.025f;
void main()
{
  vec3 albedo = get_albedo(colortex0, TexCoord);
  float depth = texture(depthtex0, TexCoord).r;
  if(depth == 1.0)
  {
    diffuse = vec4(albedo, 1.0);
    return;
  }

  vec3 normal = normalize(texture(colortex1, TexCoord).rgb * 2.0 - 1.0);
  vec2 lightmap = texture(colortex2, TexCoord).rg;
  vec3 lightmapColor = GetLightmapColor(lightmap);
  
  float NdotL = max(dot(normal, normalize(shadowLightPosition)), 0.0f);

  vec3 shadowColor = GetShadow(depth, 2, TexCoord);

  diffuse = vec4(albedo * (lightmapColor + NdotL * shadowColor + Ambient), 1.0f);
}
