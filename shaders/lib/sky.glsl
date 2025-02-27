vec3 calcSkyColor()
{
  vec3 skyColor;
  if (worldTime < 1000.0) { 
    float t = smoothstep(500.0, 1000.0, worldTime);
    skyColor = mix(sky_earlySkyColor, sky_daySkyColor, t);
  } else if (worldTime < 12350.0) {
    float t = smoothstep(10000.0, 12350.0, worldTime);
    skyColor = mix(sky_daySkyColor, sky_duskSkyColor, t);
  } else if (worldTime < 23500.0) {
    float t = smoothstep(12350.0, 13000.0, worldTime);
    skyColor = mix(sky_duskSkyColor, sky_nightSkyColor, t);
  } else {
    skyColor = sky_nightSkyColor;
  }

  return skyColor;
}

vec4 setStarColor(vec4 glcolor)
{
  return glcolor * 2;
}
