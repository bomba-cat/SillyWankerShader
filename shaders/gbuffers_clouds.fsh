#version 330 compatibility

#include "/lib/common.glsl"
#include "/lib/uniforms.glsl"
#include "/lib/color/basic_color.glsl"
#include "/lib/gamma.glsl"

in vec2 TexCoord;
in vec4 Color;

/* RENDERTARGET: 0 */
layout(location = 0) out vec4 color;

void main()
{
  color = fsh_basic_gtexture(TexCoord, Color);
  color.rgb = fsh_apply_gamma(color);
}
