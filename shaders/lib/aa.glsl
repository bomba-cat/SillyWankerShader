vec4 aa(vec2 texcoord)
{
  vec4 color = vec4(0);

  color = texture(colortex0, texcoord);

  return color;
}
