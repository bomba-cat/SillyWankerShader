vec4 get_normal(vec3 Normal)
{
  return vec4(Normal * 0.5f + 0.5f, 1.0f);
}
