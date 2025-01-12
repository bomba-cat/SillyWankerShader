#version 330 compatibility

#include "/lib/uniforms.glsl"
#include "/lib/color/basic_color.glsl"
#include "/lib/lightmap.glsl"
#include "/lib/normal.glsl"

in vec2 TexCoord;

/* RENDERTARGET: 0 */
layout(location = 0) out vec4 color;

void main()
{
  color = fsh_basic_color(TexCoord);
  vec2 lightmap = fsh_getLightmap(TexCoord);
  vec3 normal = fsh_get_normalized(TexCoord);
  color.rgb *= fsh_apply_lightColors(lightmap, normal);
}
