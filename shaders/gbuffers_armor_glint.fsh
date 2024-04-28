#version 120

varying vec2 TexCoords;
uniform sampler2D colortex0;

float rand(vec2 co){
    return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

void main() {
    // Sample and apply gamma correction
    vec3 Color = pow(texture2D(colortex0, TexCoords).rgb, vec3(1.0f / 2.2f));
    Color *= vec3(rand(TexCoords/4500));
    gl_FragColor = vec4(Color, 1.0f);
}