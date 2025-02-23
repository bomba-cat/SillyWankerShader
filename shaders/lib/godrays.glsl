vec3 doGodrays(vec3 color, vec2 texcoord) {
  color = vec3(0);

  vec2 altCoord = texcoord;

  vec3 LightVector = viewSpaceToScreenSpace(shadowLightPosition);
  LightVector.xy = clamp(LightVector.xy, vec2(-0.5), vec2(1.5));

  vec2 deltaTexCoord = (texcoord - (LightVector.xy)); 

  deltaTexCoord *= 1.0 / float(GODRAYS_SAMPLES) * density;

  float illuminationDecay = 1.0;

  altCoord -= deltaTexCoord * IGN(floor(gl_FragCoord.xy), frameCounter);

  for(int i = 0; i < GODRAYS_SAMPLES; i++)
  {
    vec3 samples = texture(depthtex0, altCoord).r == 1.0 ? vec3(1.0) * godrayColor : vec3(0.0);
    if(isEyeInWater == 1)
    {
      samples = texture(depthtex1, altCoord).r == 1.0 ? mix(vec3(0.1882, 0.902, 0.6745), godrayColor, waterTint) : vec3(0.0);
      gweight = 0.3;
      decay = 1.0;
      exposure = 0.71;
  	}
    samples *= illuminationDecay * gweight;
    color += samples;
    illuminationDecay *= decay;
    altCoord -= deltaTexCoord;
  }

  color /= GODRAYS_SAMPLES;
  color *= exposure;

  return color;
}
