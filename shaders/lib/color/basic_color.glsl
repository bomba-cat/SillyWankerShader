#ifndef BASIC_COLOR_GLSL
#define BASIC_COLOR_GLSL

vec4 fsh_basic_color(vec2 TexCoord)
{
  return texture(colortex0, TexCoord);
}

vec4 fsh_basic_gtexture(vec2 TexCoord, vec4 Color)
{
  vec4 color = texture(gtexture, TexCoord) * Color;
  if (color.a < 0.1)
  {
    discard;
  }
  return color;
}

#endif
