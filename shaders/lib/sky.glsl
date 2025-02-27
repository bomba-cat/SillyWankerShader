vec3 calcSkyColor()
{
  vec3 earlySkyColor = vec3(0.05, 0.03, 0.1);
  vec3 daySkyColor = vec3(0.4, 0.7, 1.0);
  vec3 duskSkyColor = vec3(0.1, 0.05, 0.02);
  vec3 nightSkyColor = vec3(0.01, 0.01, 0.03);
  
  vec3 skyColor;
  if (worldTime < 1000.0) { 
    float t = smoothstep(500.0, 1000.0, worldTime);
    skyColor = mix(earlySkyColor, daySkyColor, t);
  } else if (worldTime < 12350.0) {
    float t = smoothstep(10000.0, 12350.0, worldTime);
    skyColor = mix(daySkyColor, duskSkyColor, t);
  } else if (worldTime < 23500.0) {
    float t = smoothstep(12350.0, 13000.0, worldTime);
    skyColor = mix(duskSkyColor, nightSkyColor, t);
  } else {
    skyColor = nightSkyColor;
  }

  return skyColor;
}

vec4 setStarColor(vec4 glcolor)
{
  return glcolor * 2;
}
