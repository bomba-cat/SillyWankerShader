#version 330 compatibility

#include "/lib/coord/texcoord.glsl"

out vec2 TexCoord;

void main()
{
  gl_Position = ftransform();
  TexCoord = vsh_texcoord();
}
