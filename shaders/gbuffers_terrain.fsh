#version 330 compatibility

#include "/lib/common.glsl"
#include "/lib/uniforms.glsl"
#include "/lib/color/basic_color.glsl"
#include "/lib/lightmap.glsl"
#include "/lib/normal.glsl"
#include "/lib/gamma.glsl"
#include "/lib/depth.glsl"

in vec2 LightmapCoord;
in vec2 TexCoord;
in vec3 Normal;
in vec4 Color;

/* RENDERTARGET: 0,1,2 */
layout(location = 0) out vec4 color;
layout(location = 1) out vec4 lightmapData;
layout(location = 2) out vec4 normal;

void main()
{
  color.rgb = Normal;
  //color = fsh_basic_gtexture(TexCoord, Color);
  //color.rgb = fsh_apply_gamma(color);

  float depth = fsh_get_depth(TexCoord);
  if (depth == 1.0)
  {
    return;
  }
  
  lightmapData = fsh_lightmapData(LightmapCoord);

  normal = fsh_encodedNormal(Normal);
}
