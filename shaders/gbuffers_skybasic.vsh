#version 330 compatibility

#include "/lib/uniforms.glsl"

out vec4 Color;

void main()
{
  gl_Position = ftransform();

  Color = gl_Color;
}
