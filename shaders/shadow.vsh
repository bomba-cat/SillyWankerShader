#version 330 compatibility

#include "/lib/distort.glsl"

out vec2 TexCoord;
out vec4 Color;

void main()
{
  gl_Position = ftransform();
  gl_Position.xy = DistortPosition(gl_Position.xy);
  TexCoord = gl_MultiTexCoord0.st;
  Color = gl_Color;
}
