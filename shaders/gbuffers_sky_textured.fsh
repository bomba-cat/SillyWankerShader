#version 330 compatibility

#include "/lib/common.glsl"
#include "/lib/uniforms.glsl"

in vec2 TexCoord;

/* RENDERTARGET: 0 */
layout(location = 0) out vec3 color;

void main()
{
  color = texture(gtexture, texcoord);
}
