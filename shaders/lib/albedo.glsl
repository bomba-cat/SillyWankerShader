#ifndef ALBEDO_GLSL
#define ALBEDO_GLSL

vec3 get_albedo(sampler2D colortex, vec2 texcoord)
{
  return pow(texture(colortex, texcoord).rgb, vec3(2.0));
}

#endif
