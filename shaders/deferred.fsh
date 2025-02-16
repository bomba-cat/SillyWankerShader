#version 330 compatibility

#include "/lib/common.glsl"
#include "/lib/uniforms.glsl"
#include "/lib/color/basic_color.glsl"
#include "/lib/depth.glsl"
#include "/lib/lightmap.glsl"
#include "/lib/normal.glsl"
#include "/lib/distort.glsl"
#include "/lib/shadowmap.glsl"

in vec2 TexCoord;

/* RENDERTARGET: 0 */
layout(location = 0) out vec4 color;

void main()
{
  color = fsh_basic_color(TexCoord);

  float depth = fsh_get_depth(TexCoord);
  if (depth == 1.0)
  {
    return;
  }

  vec2 lightmap = fsh_getLightmap(TexCoord);
  vec3 normal = fsh_get_normalized(TexCoord);

  vec3 shadow = fsh_getShadow(TexCoord, depth);
  
  color.rgb *= fsh_apply_lightColors(lightmap, normal, shadow);
}
