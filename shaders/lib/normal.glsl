#ifndef NORMAL_GLSL
#define NORMAL_GLSL

vec3 fsh_get_normal(vec3 Normal)
{
  return Normal * 0.5f + 0.5f;
}

vec3 vsh_get_normal()
{
  return gl_NormalMatrix * gl_Normal;
}

#endif
