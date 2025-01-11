#version 330 compatibility

in vec2 TexCoord;
in vec4 Color;

uniform sampler2D texture;

/* RENDERTARGET: 0 */
layout(location = 0) out vec4 color;

void main()
{
  color = texture(texture, TexCoord) * Color;
}
