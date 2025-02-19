  float exposure = 0.36;
  float decay = 0.87;
  float density = 1.0;
  float weight = 1.0;
  vec3 earlyGodrayColor = vec3(1.0, 0.4157, 0.0);
  vec3 godrayColor = vec3(0.9882, 0.6824, 0.4314);
  vec3 moonrayColor = vec3(0.1608, 0.2941, 0.9608);
  vec3 waterTint = vec3(0.1412, 0.7412, 1.0);

vec3 doGodrays(vec2 texcoord) {
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
      weight = 0.3;
      decay = 1.0;
      exposure = 0.71;
  	}
    samples *= illuminationDecay * weight;
    color += samples;
    illuminationDecay *= decay;
    altCoord -= deltaTexCoord;
  }

  color /= GODRAYS_SAMPLES;
  color *= exposure;

  return color;
}
