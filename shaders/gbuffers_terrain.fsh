#version 330 compatibility

#include "/lib/normal.glsl"
#include "/lib/lightmap.glsl"

in vec2 TexCoord;
in vec2 LightmapCoords;
in vec3 Normal;
in vec4 Color;

uniform sampler2D texture;

/* RENDERTARGET: 0,1,2 */
layout(location = 0) out vec4 color;
layout(location = 1) out vec4 normal;
layout(location = 2) out vec4 lightmapcoords;

void main()
{
  color = texture(texture, TexCoord) * Color;
  normal = get_normal(Normal);
  lightmapcoords = get_lightmap(LightmapCoords);
}
