#version 330 compatibility

#include "/lib/common.glsl"
#include "/lib/uniforms.glsl"
#include "/lib/color/basic_color.glsl"
#include "/lib/lightmap.glsl"
#include "/lib/normal.glsl"
#include "/lib/gamma.glsl"
#include "/lib/water.glsl"

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

  if (blockId == 101)
  {
    color *= vec4(vec3(1.5), 0.3);
  } else if (blockId ==  102)
  {
    color *= vec4(vec3(1.5), 0.6);
  } else
  {
    color.a *= 0.8;
  }
  
  lightmapData = fsh_lightmapData(LightmapCoord);

  normal = fsh_encodedNormal(Normal);
}
