vec3 vsh_get_normal()
{
  return gl_NormalMatrix * gl_Normal;
}

vec3 vsh_convert_normal_to_worldplayer(vec3 normal)
{
  return mat3(gbufferModelViewInverse) * normal;
}

vec4 fsh_encodedNormal(vec3 normal)
{
  return vec4(normal * 0.5 + 0.5, 1.0);
}

vec3 fsh_get_normalized(vec2 texcoord)
{
  vec3 encodedNormal = texture(colortex2, texcoord).rgb;
  return normalize((encodedNormal - 0.5) * 2.0);
}
