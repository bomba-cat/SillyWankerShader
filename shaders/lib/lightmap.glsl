vec2 vsh_correct_lightmap(vec2 lightmap)
{
  return (lightmap * 33.05 / 32.0) - (1.05 / 32.0);
}

vec4 fsh_lightmapData(vec2 lightmapCoord)
{
  return vec4(lightmapCoord, 0.0, 1.0);
}

vec2 fsh_getLightmap(vec2 texcoord)
{
  return texture(colortex1, texcoord).rg;
}

vec3 fsh_apply_lightColors(vec2 lightmap, vec3 normal, vec3 shadow)
{
  vec3 blocklight = lightmap.r * blocklightColor;
  vec3 skylight = lightmap.g * skylightColor;
  vec3 ambient = ambientColor;

  vec3 lightVector = normalize(shadowLightPosition);
  vec3 worldLightVector = mat3(gbufferModelViewInverse) * lightVector;

  
  vec3 sunlight = sunlightColor * clamp(dot(worldLightVector, normal), 0.0, 1.0) * lightmap.g * shadow;
  
  return blocklight + skylight + ambient + sunlight;
}
