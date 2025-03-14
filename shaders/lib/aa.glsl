vec2 offsets[24] = vec2[]
(
  vec2(-1, 0),
  vec2(1, 0),
  vec2(0, -1),
  vec2(0, 1),
  vec2(1, 1),
  vec2(-1, -1),
  vec2(-1, 1),
  vec2(1, -1),
  vec2(-2, 0),
  vec2(2, 0),
  vec2(0, -2),
  vec2(0, 2),
  vec2(2, 2),
  vec2(-2, -2),
  vec2(-2, 2),
  vec2(2, -2),
  vec2(-3, 0),
  vec2(3, 0),
  vec2(0, -3),
  vec2(0, 3),
  vec2(3, 3),
  vec2(-3, -3),
  vec2(-3, 3),
  vec2(3, -3)
);

float edgeDetection(vec2 uv) {
    vec2 texelSize = vec2(1.0 / viewWidth, 1.0 / viewHeight);
    
    float left   = texture(colortex0, uv - vec2(texelSize.x, 0.0)).r;
    float right  = texture(colortex0, uv + vec2(texelSize.x, 0.0)).r;
    float bottom = texture(colortex0, uv - vec2(0.0, texelSize.y)).r;
    float top    = texture(colortex0, uv + vec2(0.0, texelSize.y)).r;

    float diffX = abs(left - right);
    float diffY = abs(bottom - top);

    return diffX + diffY;
}

vec4 aa(vec2 TexCoord)
{
  vec4 color = vec4(0);
  vec2 texelSize = vec2(1.0 / viewWidth, 1.0 / viewHeight);

  int samples = AA_SAMPLES;

  float edge = edgeDetection(TexCoord);

  if (edge > 0.05)
  {
    for(int i = 0; i < samples; i++)
    {
      color += texture(colortex0, TexCoord + offsets[i] * texelSize);
    }
  } else
  {
    return texture(colortex0, TexCoord);
  }
  color /= samples;

  return color;
}
