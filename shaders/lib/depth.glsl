float fsh_get_depth(vec2 texcoord)
{
  return texture(depthtex1, texcoord).r;
}
