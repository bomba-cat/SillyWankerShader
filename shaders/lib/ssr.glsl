vec3 ScreenUVToViewPos(vec2 uv, float depth)
{
  vec4 clipSpace = vec4(uv * 2.0 - 1.0, depth, 1.0);
  vec4 viewSpace = gbufferProjectionInverse * clipSpace;
  return viewSpace.xyz / viewSpace.w;
}

vec2 ViewPosToScreenUV(vec3 viewPos)
{
  vec4 clipSpace = gbufferProjection * vec4(viewPos, 1.0);
  return clipSpace.xy / clipSpace.w * 0.5 + 0.5;
}

vec3 SSRRaymarch(vec3 viewPos, vec3 normal, out float hitStrength)
{
  vec3 viewDir = normalize(viewPos);
  vec3 reflectDir = reflect(viewDir, normal);

  float stepSize = 0.1;
  int maxSteps = 60;

  vec3 rayPos = viewPos + normal * 0.1;
  vec3 step = reflectDir * stepSize;

  hitStrength = 0.0;
  vec3 hitColor = vec3(0.0);

  for (int i = 0; i < maxSteps; i++)
  {
    rayPos += step;

    vec2 uv = ViewPosToScreenUV(rayPos);

    if (uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0)
    {
      break;
    }

    float sceneDepth = texture(depthtex1, uv).r;
    vec3 scenePos = ScreenUVToViewPos(uv, sceneDepth);

    if (distance(rayPos, scenePos) < stepSize * 2.0)
    {
      hitColor = texture(colortex0, uv).rgb;
      hitStrength = 1.0 - (float(i) / float(maxSteps));
      break;
    }
  }

  return hitColor;
}

vec3 ApplySSR(vec2 texCoord, vec3 baseColor)
{
  float depth = fsh_get_depth(texCoord);
  if (depth >= 1.0)
  {
    return baseColor;
  }

  vec3 viewPos = ScreenUVToViewPos(texCoord, depth);
  vec3 normal = fsh_get_normalized(texCoord);

  float materialReflectivity = 0.5;

  float hitStrength;
  vec3 reflectionColor = SSRRaymarch(viewPos, normal, hitStrength);

  float reflectionAmount = materialReflectivity * hitStrength;
  return mix(baseColor, reflectionColor, reflectionAmount);
}
