#version 330 compatibility

#include "/lib/uniforms.glsl"
#include "/lib/common.glsl"

in vec2 TexCoord;

/* RENDERTARGET: 0 */
layout(location = 0) out vec3 color;

void main()
{
  color = pow(texture(colortex0, TexCoord).rgb, vec3(1.0f / 2.2f));
}
