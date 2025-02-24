#version 330 compatibility

#include "/lib/common.glsl"
#include "/lib/uniforms.glsl"
#include "/lib/color/basic_color.glsl"
#include "/lib/depth.glsl"
#include "/lib/bloom.glsl"

in vec2 TexCoord;

/* RENDERTARGET: 0 */
layout(location = 0) out vec4 color;

void main()
{
  color = fsh_basic_color(TexCoord);

  #if BLOOM_ENABLED == 1
    color.rgb += texture(colortex5, TexCoord).rgb;
  #endif
}
