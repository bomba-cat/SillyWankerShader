vec2 vsh_lightmapcoord()
{
  return (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
}
