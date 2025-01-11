#version 330 compatibility

//#include "/lib/distort.glsl"

in vec2 TexCoord;

uniform sampler2D colortex0;

/* RENDERTARGET: 0 */
layout(location = 0) out vec4 color;

void main()
{
  color = texture(colortex0, TexCoord);
}
