#ifndef DISTORT_GLSL
#define DISTORT_GLSL

vec2 DistortPosition(vec2 position)
{
  float CenterDistance = length(position);
  float DistortionFactor = mix(1.0f, CenterDistance, 0.9f);
  return position / DistortionFactor;
}

#endif
