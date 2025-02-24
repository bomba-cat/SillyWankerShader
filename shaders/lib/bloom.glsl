vec4 HDRColorExtraction(vec4 color)
{
  float brightness = dot(color.rgb, vec3(0.251, 0.8745, 0.0784));
  if(brightness > 0.88)
  {
    color = vec4(color.rgb, 1.0);
  } else
  {
    color = vec4(0.0, 0.0, 0.0, 1.0);
  }

  return color;
}

vec4 horizontalBlur(vec4 color, vec2 texcoord)
{
  vec2 tex_offset =  3.0  / textureSize(colortex5, 0);
  vec3 result = texture(colortex5, texcoord).rgb * weight[0];

  for(int i = 0; i < 5; ++i)
  {
    result += texture(colortex5, texcoord + vec2(tex_offset.x * i, 0.0)).rgb * weight[i];
    result += texture(colortex5, texcoord - vec2(tex_offset.x * i, 0.0)).rgb * weight[i];
  }

  return vec4(result, 1.0);
}

vec4 verticalBlur(vec4 color, vec2 texcoord)
{
  vec2 tex_offset = 3.0 / textureSize(colortex5, 0);
  vec3 result = texture(colortex5, texcoord).rgb * weight[0];
  if(horizontal)
  {
    for(int i = 1; i < 5; ++i)
    {
      result += texture(colortex5, texcoord + vec2(tex_offset.x * i, 0.0)).rgb * weight[i];
      result += texture(colortex5, texcoord - vec2(tex_offset.x * i, 0.0)).rgb * weight[i];
    }
  } else
  {
    for(int i = 1; i < 5; ++i)
    {
      result += texture(colortex5, texcoord + vec2(0.0, tex_offset.y * i)).rgb * weight[i];
      result += texture(colortex5, texcoord - vec2(0.0, tex_offset.y * i)).rgb * weight[i];
    }
  }

  return vec4(result, 1.0);
}

vec4 finalCombine(vec4 color, vec2 texcoord)
{
  float exposure = 1.0;
  const float gamma = 2.2;

  vec3 hdrColor = texture(colortex5, texcoord).rgb;      
  vec3 bloomColor = texture(colortex5, texcoord).rgb;
  hdrColor += bloomColor;

  vec3 result = vec3(1.0) - exp(-hdrColor * exposure);

  result = pow(result, vec3(1.0 / gamma));

  return vec4(result, 1.0);
}
