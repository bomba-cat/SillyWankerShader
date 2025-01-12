#ifndef DEPTH_GLSL
#define DEPTH_GLSL

float fsh_get_depth(vec2 texcoord)
{
  return texture(depthtex1, texcoord).r;
}

#endif
