#include "/lib/tonemapping_variables.glsl"

//base uncharted2 tonemap calculation
vec3 uncharted2Tonemap(vec3 x) {
   float A = U2_SHOULDER;
   float B = U2_LINEAR_STRENGTH;
   float C = U2_LINEAR_ANGLE;
   float D = U2_TOE;
   float E = U2_TOE_NUMERATOR;
   float F = U2_TOE_DENOMINATOR;
  float W = 11.2;
  return ((x * (A * x + C * B) + D * E) / (x * (A * x + B) + D * F)) - E / F;
}

//applies exposure compensation and filmic correction
vec3 uncharted2(vec3 y) {
  const float W = 11.2;
  float exposureBias = 2.0;
  vec3 curr = uncharted2Tonemap(exposureBias * y);
  vec3 whiteScale = 1.0 / uncharted2Tonemap(vec3(W));
  return curr * whiteScale;
}
