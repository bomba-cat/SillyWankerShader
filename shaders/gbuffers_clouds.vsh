#version 330 compatibility

#include "/lib/uniforms.glsl"
#include "/lib/coord/texcoord.glsl"

out vec2 TexCoord;
out vec4 Color;

void main()
{
  gl_Position = ftransform();
  
  TexCoord = vsh_texcoord();

  Color = gl_Color;
}
