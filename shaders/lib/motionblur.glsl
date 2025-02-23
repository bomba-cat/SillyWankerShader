float pseudoRandom(vec2 coords)
{
    return fract(sin(dot(coords, vec2(91.453, 53.125))) * 43758.5453);
}

float computeAdaptiveBlur(vec2 motionVec)
{
    return clamp(length(motionVec) * MAX_BLUR_AMOUNT, 0.0, MAX_BLUR_AMOUNT);
}

vec3 computeMotionBlur(vec3 inputColor, vec2 uv)
{
    float depth = texture(depthtex1, uv).r;
    if (depth <= DEPTH_THRESHOLD)
    {
      return inputColor;
    }

    vec4 currentClip = vec4(uv, depth, 1.0) * 2.0 - 1.0;
    vec4 worldPos = gbufferProjectionInverse * currentClip;
    worldPos = gbufferModelViewInverse * worldPos;
    worldPos /= worldPos.w;

    vec3 motionOffset = cameraPosition - previousCameraPosition;
    vec4 previousClip = gbufferPreviousProjection * gbufferPreviousModelView * (worldPos + vec4(motionOffset, 0.0));
    previousClip /= previousClip.w;

    vec2 motionVector = (currentClip.xy - previousClip.xy) / (1.0 + length(currentClip.xy - previousClip.xy));
    //float blurAmount = computeAdaptiveBlur(motionVector);
    motionVector *= MAX_BLUR_AMOUNT;
    //motionVector *= blurAmount;

    vec3 blurredColor = vec3(0.0);
    float totalWeight = 0.0;

    for (int i = 0; i < BLUR_SAMPLES; i++) {
        float sampleWeight = (float(i) + pseudoRandom(uv * frameTimeCounter)) / float(BLUR_SAMPLES - 1);
        vec2 sampleOffset = motionVector * (sampleWeight - 0.5);
        vec2 sampledUV = clamp(uv + sampleOffset, vec2(0.0), vec2(1.0));

        float sampleDepth = texture(depthtex1, sampledUV).r;
        if (abs(sampleDepth - depth) > EDGE_THRESHOLD)
        {
          continue;
        }

        vec3 sampledColor = texture(colortex0, sampledUV).rgb;
        float weight = exp(-sampleWeight * 3.0);

        blurredColor += sampledColor * weight;
        totalWeight += weight;
    }

    return (totalWeight > 0.0) ? (blurredColor / totalWeight) * COLOR_INTENSITY : inputColor;
}
