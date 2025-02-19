#version 330 compatibility

#include "/lib/common.glsl"
#include "/lib/uniforms.glsl"
#include "/lib/utilFunctions.glsl"
#include "/lib/godrays.glsl"

in vec2 TexCoord;

/* RENDERTARGET: 7 */
layout(location = 0) out vec3 color;

void main()
{
  color = doGodrays(TexCoord);
}
