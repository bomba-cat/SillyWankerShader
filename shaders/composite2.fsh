#version 330 compatibility

#include "/lib/common.glsl"
#include "/lib/uniforms.glsl"
#include "/lib/color/basic_color.glsl"
#include "/lib/lightmap.glsl"
#include "/lib/normal.glsl"
#include "/lib/depth.glsl"
#include "/lib/utilFunctions.glsl"
#include "/lib/godrays.glsl"

in vec2 TexCoord;

/* RENDERTARGETS: 0,7 */
layout(location = 0) out vec4 Color;
layout(location = 1) out vec3 color;

void main()
{
  Color = fsh_basic_color(TexCoord);

  float depth = fsh_get_depth(TexCoord);
  if(depth == 1.0)
  {
    return;
  }

  #if GODRAYS_ENABLED == 1
    color = doGodrays(color, TexCoord);
  #endif
}
