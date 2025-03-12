float fsh_get_depth(vec2 texcoord)
{
  return texture(depthtex0, texcoord).r;
}
