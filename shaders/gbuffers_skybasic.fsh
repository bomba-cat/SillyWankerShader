#version 330 compatibility

#include "/lib/common.glsl"
#include "/lib/uniforms.glsl"
#include "/lib/sky.glsl"

in vec4 Color;

/* RENDERTARGET: 0 */
layout(location = 0) out vec4 color;

void main()
{
  if (renderStage == MC_RENDER_STAGE_STARS)
  {
    color = setStarColor(Color);
    color.a *= 10;
  } else {
    color.rgb = calcSkyColor();
  }
}
