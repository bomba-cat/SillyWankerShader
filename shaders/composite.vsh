#version 330 compatibility

out vec2 TexCoord;

void main()
{
  gl_Position = ftransform();
  TexCoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
}
