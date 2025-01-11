#version 330 compatibility

#include "/lib/lightmap.glsl"
#include "/lib/normal.glsl"

out vec2 TexCoord;
out vec2 LightmapCoord;
out vec3 Normal;
out vec4 Color;

void main()
{
  gl_Position = ftransform();
  TexCoord = gl_MultiTexCoord0.xy;
  LightmapCoords = vsh_get_lightmap();
  Normal = vsh_get_normal();
  Color = gl_Color;
}
