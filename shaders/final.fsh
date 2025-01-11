#version 330 compatibility

in vec2 TexCoord;

uniform sampler2D colortex0;

/* RENDERTARGET: 0 */
layout(location = 0) out vec3 color;

void main()
{
  color = pow(texture(colortex0, TexCoord).rgb, vec3(1.0f / 2.2f));
}
