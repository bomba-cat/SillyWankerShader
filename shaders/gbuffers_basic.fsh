#version 120

varying vec2 TexCoords;
varying vec4 Color;

#include "lib/random_color.glsl"

#define SELECTION_RED 0 // [0 1 2 3 4 5 6 7 8 9 10]
#define SELECTION_GREEN 0 // [0 1 2 3 4 5 6 7 8 9 10]
#define SELECTION_BLUE 0 // [0 1 2 3 4 5 6 7 8 9 10]
#define CUSTOM 1 // [0 1]

void main() {
    #if CUSTOM == 1
        vec3 Color = randomColor();
    #elif CUSTOM == 0
        vec3 Color = vec3(SELECTION_RED, SELECTION_GREEN, SELECTION_BLUE);
    #endif

    gl_FragColor = vec4(Color, 1.0f);
}