vec2 vsh_texcoord()
{
  return (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
}
