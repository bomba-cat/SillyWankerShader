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
  vec3 lightVector = normalize(shadowLightPosition);
  vec3 worldLightVector = mat3(gbufferModelViewInverse) * lightVector;
  
  vec3 blocklight = lightmap.r * blocklightColor * 1.5;
  vec3 skylight = lightmap.g * skylightColor;
  vec3 ambient = ambientColor;
  
  float sunDot = clamp(dot(worldLightVector, normal), 0.0, 1.0);
  vec3 sunlight = sunlightColor * sunDot * lightmap.g * shadow;
  
  if (worldTime >= 0 && worldTime < 1000)
  {
    float time = smoothstep(0, 1000, float(worldTime));
    sunlight = mix(morningSunlightColor, sunlight, time) * sunDot * shadow;
    skylight = mix(morningSkyColor / 18, skylightColor, time) * lightmap.g;
  } else if (worldTime >= 1000 && worldTime < 11500)
  {
    float time = smoothstep(10000, 11500, float(worldTime));
    sunlight = mix(sunlightColor, duskSunlightColor, time) * sunDot * shadow;
    skylight = mix(skylightColor, duskSkyColor / 18, time) * lightmap.g;
  } else if (worldTime >= 11500 && worldTime < 13000)
  {
    float time = smoothstep(11500, 13000, float(worldTime));
    sunlight = mix(duskSunlightColor, moonlightColor / 12, time) * sunDot * shadow;
    skylight = mix(duskSkyColor / 18, nightSkyColor / 14, time) * lightmap.g;
    ambient = mix(ambientColor, nightAmbientColor / 8, time);
  } else if (worldTime >= 13000 && worldTime < 24000)
  {
    float time = smoothstep(23215, 24000, float(worldTime));
    sunlight = mix(moonlightColor / 17, morningSunlightColor, time) * sunDot * shadow;
    skylight = mix(nightSkyColor / 18, morningSkyColor / 18, time) * lightmap.g;
    ambient = mix(nightAmbientColor / 8, ambientColor / 4, time);
  }

  return blocklight + skylight + ambient + sunlight;
}
