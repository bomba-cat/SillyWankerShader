vec3 doGodrays(vec3 color, vec2 texcoord)
{
  color = vec3(0);

  vec2 altCoord = texcoord;

  vec3 LightVector = viewSpaceToScreenSpace(shadowLightPosition);
  LightVector.xy = clamp(LightVector.xy, vec2(-0.5), vec2(1.5));

  vec2 deltaTexCoord = (texcoord - LightVector.xy);
  deltaTexCoord *= 1.0 / float(GODRAYS_SAMPLES) * GODRAYS_DENSITY;

  float illuminationDecay = 2.0;
  float weight = 0.23 * SUN_ILLUMINANCE;

  altCoord -= deltaTexCoord * IGN(floor(gl_FragCoord.xy), frameCounter);

  for (int i = 0; i < GODRAYS_SAMPLES; i++)
  {
    vec3 samples = vec3(0.0);

    if (texture(depthtex0, altCoord).r == 1.0)
    {
      if (worldTime < 1000) { 
        float t = smoothstep(500, 1000, float(worldTime));
        samples = mix(earlyGodrayColor, godrayColor, t);
      } 
      else if (worldTime < 12350)
      {
        float t = smoothstep(10000, 12350, float(worldTime));
        samples = mix(godrayColor, duskGodrayColor, t);
      } 
      else if (worldTime < 23500) 
      {
        float t = smoothstep(12350, 13000, float(worldTime));
        samples = mix(earlyGodrayColor, moonrayColor, t);
        weight = 0.14 * MOON_ILLUMINANCE;
      }
    }

    if (isEyeInWater == 1)
    {
      if (texture(depthtex1, altCoord).r == 1.0)
      {
        samples = mix(vec3(0.0941, 0.0392, 0.8275), godrayColor, waterTint);
      }
      weight = 0.3;
      samples *= 1.2; // This was your exposure tweak under water
    }

    samples *= illuminationDecay * weight;
    color += samples;
    illuminationDecay *= GODRAYS_DECAY;
    altCoord -= deltaTexCoord;
  }

  color /= GODRAYS_SAMPLES;
  color *= GODRAYS_EXPOSURE;

  return color;
}
