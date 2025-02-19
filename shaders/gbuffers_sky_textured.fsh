#version 330 compatibility

#include "/lib/common.glsl"
#include "/lib/uniforms.glsl"
#include "/lib/utilFunctions.glsl"
#include "/lib/godrays.glsl"

in vec2 TexCoord;

/* RENDERTARGET: 0, 7 */
layout(location = 0) out vec3 color;
layout(location = 1) out vec4 godraySample;

void main()
{
  color = texture(gtexture, texcoord) * glcolor * 2;
  godraySample = doGodrays(TexCoord);
}
