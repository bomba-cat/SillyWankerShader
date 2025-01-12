#version 330 compatibility

#include "/lib/uniforms.glsl"
#include "/lib/common.glsl"
#include "/lib/normal.glsl"
#include "/lib/lightmap.glsl"

in vec2 TexCoord;
in vec2 LightmapCoords;
in vec3 Normal;
in vec4 Color;

/* RENDERTARGET: 0,1,2 */
layout(location = 0) out vec4 color;
layout(location = 1) out vec4 normal;
layout(location = 2) out vec4 lightmapcoords;

void main()
{
  color = texture(texture, TexCoord) * Color;
  color.rgb = pow(color.rgb, vec3(2.2));

  if (color.a < 0.1) //Skip transparent pixels
  {
    discard;
  }

  normal = vec4(fsh_get_normal(Normal), 1.0);
  lightmapcoords = fsh_get_lightmap(LightmapCoords);
}
