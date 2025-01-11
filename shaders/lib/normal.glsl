#ifndef NORMAL_GLSL
#define NORMAL_GLSL

vec4 fsh_get_normal(vec3 Normal)
{
  return vec4(Normal * 0.5f + 0.5f, 1.0f);
}

vec3 vsh_get_normal()
{
  return gl_NormalMatrix * gl_Normal;
}

#endif
