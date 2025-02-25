vec3 calcSkyColor() {
  vec4 screenPos = vec4(gl_FragCoord.xy / vec2(viewWidth, viewHeight), gl_FragCoord.z, 1.0);
  vec4 viewPos = gbufferProjectionInverse * (screenPos * 2.0 - 1.0);
  viewPos /= viewPos.w;

  vec3 normalViewPos = normalize(viewPos.xyz);

  vec3 pos = normalize(normalViewPos);

  vec3 horizonColor = fogColor;
  vec3 zenithColor = skyColor;
   
  
    if(worldTime >= 0 && worldTime < 1000)
    {
        float time = smoothstep(0, 1000, float(worldTime));
        horizonColor = mix(earlyFogColor, fogColor, time);
        zenithColor =  mix(earlySkyColor, skyColor, time);
    }
    else if(worldTime >= 1000 && worldTime < 11500)
     {
        float time = smoothstep(10000, 11500, float(worldTime));
        horizonColor = mix(fogColor, earlyFogColor, time);
        zenithColor =  mix(skyColor, earlySkyColor, time);
    }
    else if(worldTime >= 11500 && worldTime < 13000)
     {
        float time = smoothstep(11500, 13000, float(worldTime));
        horizonColor = mix(lateFogColor, nightFogColor, time);
        zenithColor =  mix(lateSkyColor, skynightSkyColor, time);
    }
    else if(worldTime >= 13000 && worldTime < 24000)
    {
        float time = smoothstep(23215, 24000, float(worldTime));
        horizonColor = mix(nightFogColor, earlyFogColor, time);
        zenithColor =  mix(skynightSkyColor, earlySkyColor, time);
    }

    vec3 currentSkyColor = zenithColor;
    vec3 currentHorizonColor = horizonColor;

    float upDot = dot(pos, gbufferModelView[1].xyz);
    return mix(zenithColor, horizonColor, 0.7);
}

vec4 setStarColor(vec4 glcolor)
{
  return glcolor * 2;
}
