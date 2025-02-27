#version 330 compatibility

#include "/lib/common.glsl"
#include "/lib/uniforms.glsl"
#include "/lib/sky.glsl"

in vec4 Color;

/* RENDERTARGETS: 0,6 */
layout(location = 0) out vec4 color;
layout(location = 1) out vec4 skyColor;

void main()
{
  if (renderStage == MC_RENDER_STAGE_STARS)
  {
    color = setStarColor(Color);
  } else {
    color.rgb = calcSkyColor();
  }
}
