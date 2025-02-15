#version 330 compatibility

#include "/lib/uniforms.glsl"
#include "/lib/coord/texcoord.glsl"
#include "/lib/distort.glsl"

out vec2 TexCoord;
out vec4 Color;

void main()
{
  gl_Position = ftransform();
  gl_Position.xyz = distortShadowClipPos(gl_Position.xyz);
  TexCoord = vsh_texcoord();
  Color = gl_Color;
}
