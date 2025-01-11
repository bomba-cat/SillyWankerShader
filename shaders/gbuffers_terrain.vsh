#version 330 compatibility

out vec2 TexCoord;
out vec2 LightmapCoord;
out vec3 Normal;
out vec4 Color;

void main()
{
  gl_Position = ftransform();
  TexCoord = gl_MultiTexCoord0.xy;
  LightmapCoords = mat2(gl_TextureMatrix[1]) * gl_MultiTexCoord0.st;
  LightmapCoords = (LightmapCoords * 33.05f / 32.0f) - (1.05f / 32.0f);
  Normal = gl_NormalMatrix * gl_Normal;
  Color = gl_Color;
}
