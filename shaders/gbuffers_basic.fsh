#version 120

varying vec2 TexCoords;
varying vec4 Color;

#include "lib/random_color.glsl"

void main() {
    vec3 Color = randomColor();

    gl_FragColor = vec4(Color, 1.0f);
}