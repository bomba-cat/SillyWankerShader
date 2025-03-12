vec3 fsh_get_shadowmap(texcoord)
{
  return texture(shadowtex0, texcoord).rgb;
}

vec3 projectAndDivide(mat4 projectionMatrix, vec3 position)
{
  vec4 homPos = projectionMatrix * vec4(position, 1.0);
  return homPos.xyz / homPos.w;
}

vec3 getShadow(vec3 shadowScreenPos)
{
  float transparentShadow = step(shadowScreenPos.z, texture(shadowtex0, shadowScreenPos.xy).r);

  if(transparentShadow == 1.0)
  {
    return vec3(1.0, 1.0, 1.0);
  }

  float opaqueShadow = step(shadowScreenPos.z, texture(shadowtex1, shadowScreenPos.xy).r);

  if(opaqueShadow == 0.0)
  {
    return vec3(0.0, 0.0, 0.0);
  }

  vec4 shadowColor = texture(shadowcolor0, shadowScreenPos.xy);

  return shadowColor.rgb * (1.0 - shadowColor.a);
}

vec4 getNoise(vec2 coord)
{
  ivec2 screenCoord = ivec2(coord * vec2(viewWidth, viewHeight));
  ivec2 noiseCoord = screenCoord % 64;
  return texelFetch(noisetex, noiseCoord, 0);
}

vec4 getShadowClipPos(vec2 texcoord, float depth)
{
  vec3 NDCPos = vec3(texcoord.xy, depth) * 2.0 - 1.0;
	vec3 viewPos = projectAndDivide(gbufferProjectionInverse, NDCPos);
	vec3 feetPlayerPos = (gbufferModelViewInverse * vec4(viewPos, 1.0)).xyz;
	vec3 shadowViewPos = (shadowModelView * vec4(feetPlayerPos, 1.0)).xyz;
	return shadowProjection * vec4(shadowViewPos, 1.0);
}

vec3 getSoftShadow(vec2 texcoord, float depth)
{
  vec4 shadowClipPos = getShadowClipPos(texcoord, depth);
  const float range = SHADOW_SOFTNESS / 2;
  const float increment = range / SHADOW_QUALITY;

  float noise = getNoise(texcoord).r;

  float theta = noise * radians(360.0);
  float cosTheta = cos(theta);
  float sinTheta = sin(theta);

  mat2 rotation = mat2(cosTheta, -sinTheta, sinTheta, cosTheta);

  vec3 shadowAccum = vec3(0.0);
  int samples = 0;

  for(float x = -range; x <= range; x += increment)
  {
    for (float y = -range; y <= range; y+= increment)
    {
      vec2 offset = rotation * vec2(x, y) / shadowMapResolution;
      vec4 offsetShadowClipPos = shadowClipPos + vec4(offset, 0.0, 0.0);
      offsetShadowClipPos.z -= 0.0017;
      offsetShadowClipPos.xyz = distortShadowClipPos(offsetShadowClipPos.xyz);
      vec3 shadowNDCPos = offsetShadowClipPos.xyz / offsetShadowClipPos.w;
      vec3 shadowScreenPos = shadowNDCPos * 0.5 + 0.5;
      shadowAccum += getShadow(shadowScreenPos);
      samples++;
    }
  }

  return shadowAccum / float(samples);
}

vec3 fsh_getShadow(vec2 texcoord, float depth)
{
  return getSoftShadow(texcoord, depth);
}
