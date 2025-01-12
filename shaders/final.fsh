#version 330 compatibility

#include "/lib/uniforms.glsl"
#include "/lib/color/basic_color.glsl"
#include "/lib/gamma.glsl"

in vec2 TexCoord;

/* RENDERTARGET: 0 */
layout(location = 0) out vec4 color;

void main()
{
  color = fsh_basic_color(TexCoord);
  color.rgb = fsh_apply_inversegamma(color);
}
