#version 330 compatibility

#include "/lib/common.glsl"
#include "/lib/uniforms.glsl"
#include "/lib/coord/texcoord.glsl"
#include "/lib/coord/lightmapcoord.glsl"
#include "/lib/lightmap.glsl"
#include "/lib/normal.glsl"
#include "/lib/water.glsl"

out vec2 LightmapCoord;
out vec2 TexCoord;
out vec3 Normal;
out vec4 Color;

void main()
{
  gl_Position = ftransform();
  
  if (blockEntityId == 1001)
  {
    gl_Position.y += vsh_getWaveHeight(gl_Position.xyz);
  }
  
  TexCoord = vsh_texcoord();

  LightmapCoord = vsh_lightmapcoord();
  LightmapCoord = vsh_correct_lightmap(LightmapCoord);
  
  Normal = vsh_get_normal();
  Normal = vsh_convert_normal_to_worldplayer(Normal);

  Color = gl_Color;
}
