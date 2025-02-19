#version 330 compatibility

#include "/lib/common.glsl"
#include "/lib/uniforms.glsl"
#include "/lib/color/basic_color.glsl"

in vec2 TexCoord;

/* RENDERTARGET: 0 */
layout(location = 0) out vec4 color;

void main()
{
  color = fsh_basic_color(TexCoord);
}
