#version 330 compatibility

#include "/lib/common.glsl"
#include "/lib/uniforms.glsl"
#include "/lib/color/basic_color.glsl"
#include "/lib/lightmap.glsl"
#include "/lib/normal.glsl"
#include "/lib/depth.glsl"
#include "/lib/motionblur.glsl"

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

  #if MOTION_BLUR_ENABLED == 1
    color.rgb = computeMotionBlur(color.rgb, TexCoord);
  #endif
}
