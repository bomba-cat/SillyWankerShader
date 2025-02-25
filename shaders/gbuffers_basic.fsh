#version 330 compatibility

#include "/lib/common.glsl"
#include "/lib/uniforms.glsl"
#include "/lib/color/basic_color.glsl"
#include "/lib/gamma.glsl"
#include "/lib/outline.glsl"

in vec2 LightmapCoord;
in vec2 TexCoord;
in vec3 Normal;
in vec4 Color;

/* RENDERTARGETS: 0,1,2 */
layout(location = 0) out vec4 color;

void main()
{
  color = setColor();
  color.rgb = fsh_apply_gamma(color);
}
