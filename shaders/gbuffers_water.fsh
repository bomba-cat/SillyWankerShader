#version 330 compatibility

#include "/lib/common.glsl"
#include "/lib/uniforms.glsl"
#include "/lib/color/basic_color.glsl"
#include "/lib/lightmap.glsl"
#include "/lib/depth.glsl"
#include "/lib/normal.glsl"
#include "/lib/gamma.glsl"
#include "/lib/water.glsl"
#include "/lib/distort.glsl"
#include "/lib/shadowmap.glsl"
#include "/lib/ssr.glsl"

in vec2 LightmapCoord;
in vec2 TexCoord;
in vec3 Normal;
in vec4 Color;
flat in int blockId;

/* RENDERTARGETS: 0,1,2 */
layout(location = 0) out vec4 color;
layout(location = 1) out vec4 lightmapData;
layout(location = 2) out vec4 normal;

void main()
{
  color = fsh_basic_gtexture(TexCoord, Color);
  color.rgb = fsh_apply_gamma(color);

  float depth = fsh_get_depth(TexCoord);

  if (blockId == 101)
  {
    color *= vec4(vec3(0.8), 0.5);
  } else if (blockId == 102)
  {
    color *= vec4(vec3(1.5), 0.6);
  } else
  {
    color *= vec4(vec3(0.2), 0.9);
  }

  lightmapData = fsh_lightmapData(LightmapCoord);

  normal = fsh_encodedNormal(Normal);
}
