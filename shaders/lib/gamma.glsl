vec3 fsh_apply_gamma(vec4 color)
{
  return pow(color.rgb, vec3(2.2));
}

vec3 fsh_apply_inversegamma(vec4 color)
{
  return pow(color.rgb, vec3(1.0/2.2));
}
