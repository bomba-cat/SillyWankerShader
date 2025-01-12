#version 330 compatibility

#include "/lib/uniforms.glsl"
#include "/lib/common.glsl"
#include "/lib/distort.glsl"
#include "/lib/albedo.glsl"
#include "/lib/lightmap.glsl"
#include "/lib/shadow.glsl"

in vec2 TexCoord;

/* RENDERTARGET: 0 */
layout(location = 0) out vec4 color;

const float Ambient = 0.025f;
void main()
{
  vec3 albedo = get_albedo(colortex0, TexCoord);
  
  vec3 normal = normalize((texture(colortex1, TexCoord).rgb - 0.5) * 2.0);
  vec2 lightmap = texture(colortex2, TexCoord).rg;

  color.rgb = vec3(lightmap, 0.0); 
}
