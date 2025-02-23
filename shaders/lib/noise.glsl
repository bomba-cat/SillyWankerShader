float hash(vec2 p) {
    p = fract(p * vec2(123.34, 456.21));
    p += dot(p, p + 45.32);
    return fract(p.x * p.y);
}

float blueNoise(vec2 uv) {
    vec2 grid = floor(uv * iResolution.xy);
    return hash(grid);
}
