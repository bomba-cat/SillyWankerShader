#version 330 compatibility

#include "/lib/common.glsl"
#include "/lib/uniforms.glsl"
#include "/lib/color/basic_color.glsl"
#include "/lib/gamma.glsl"
#include "lib/tonemapping.glsl"


in vec2 TexCoord;

/* RENDERTARGET: 0 */
layout(location = 0) out vec4 color;

void main()
{
  color = fsh_basic_color(TexCoord);
  color.rgb = uncharted2(pow(color.rgb, vec3 (1.0/2.2)));
}
