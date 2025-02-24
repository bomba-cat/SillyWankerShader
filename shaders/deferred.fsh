#version 330 compatibility

#include "/lib/common.glsl"
#include "/lib/uniforms.glsl"
#include "/lib/color/basic_color.glsl"
#include "/lib/depth.glsl"
#include "/lib/lightmap.glsl"
#include "/lib/normal.glsl"
#include "/lib/distort.glsl"
#include "/lib/shadowmap.glsl"

in vec2 TexCoord;

/* RENDERTARGET: 0 */
layout(location = 0) out vec4 color;

void main()
{
  color = fsh_basic_color(TexCoord);

  float depth = fsh_get_depth(TexCoord);
  if (depth == 1.0)
  {
    return;
  }

  #if FULLBRIGHT == 0
    vec2 lightmap = fsh_getLightmap(TexCoord);
    vec3 normal = fsh_get_normalized(TexCoord);

    #if SHADOW_ENABLED == 1
      vec3 shadow = fsh_getShadow(TexCoord, depth);
    #else
      vec3 shadow = vec3(1);
    #endif
  
    color.rgb *= fsh_apply_lightColors(lightmap, normal, shadow);
  #endif
}
