#version 330 compatibility

#include "/lib/common.glsl"
#include "/lib/uniforms.glsl"
#include "/lib/color/basic_color.glsl"
#include "/lib/depth.glsl"
#include "/lib/bloom.glsl"

in vec2 TexCoord;

/* RENDERTARGETS: 0,5 */
layout(location = 0) out vec4 Color;
layout(location = 1) out vec4 color;

void main()
{
  Color = fsh_basic_color(TexCoord);

  float depth = fsh_get_depth(TexCoord);
  if (depth == 1.0)
  {
    return;
  }

  color = verticalBlur(Color, TexCoord);
}
