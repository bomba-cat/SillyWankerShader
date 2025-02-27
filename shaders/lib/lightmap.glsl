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
    
    vec3 blocklight = lightmap.r * lightmap_blocklightColor * 1.5;
    vec3 skylight = lightmap.g * lightmap_skylightColor;
    vec3 ambient = lightmap_ambientColor;
    
    float sunDot = clamp(dot(worldLightVector, normal), 0.0, 1.0);
    vec3 sunlight = lightmap_sunlightColor * sunDot * lightmap.g * shadow;
    
    if (worldTime >= 0 && worldTime < 1000)
    {
        float time = smoothstep(0, 1000, float(worldTime));
        sunlight = mix(lightmap_morningSunlightColor, sunlight, time) * sunDot * shadow;
        skylight = mix(lightmap_morningSkyColor / 18, lightmap_skylightColor, time) * lightmap.g;
    } 
    else if (worldTime >= 1000 && worldTime < 11500)
    {
        float time = smoothstep(10000, 11500, float(worldTime));
        sunlight = mix(lightmap_sunlightColor, lightmap_duskSunlightColor, time) * sunDot * shadow;
        skylight = mix(lightmap_skylightColor, lightmap_duskSkyColor / 18, time) * lightmap.g;
    } 
    else if (worldTime >= 11500 && worldTime < 13000)
    {
        float time = smoothstep(11500, 13000, float(worldTime));
        sunlight = mix(lightmap_duskSunlightColor, lightmap_moonlightColor / 12, time) * sunDot * shadow;
        skylight = mix(lightmap_duskSkyColor / 18, lightmap_nightSkyColor / 14, time) * lightmap.g;
        ambient = mix(lightmap_ambientColor, lightmap_nightAmbientColor / 8, time);
    } 
    else if (worldTime >= 13000 && worldTime < 24000)
    {
        float time = smoothstep(23215, 24000, float(worldTime));
        sunlight = mix(lightmap_moonlightColor / 17, lightmap_morningSunlightColor, time) * sunDot * shadow;
        skylight = mix(lightmap_nightSkyColor / 18, lightmap_morningSkyColor / 18, time) * lightmap.g;
        ambient = mix(lightmap_nightAmbientColor / 8, lightmap_ambientColor / 4, time);
    }

    return blocklight + skylight + ambient + sunlight;
}
