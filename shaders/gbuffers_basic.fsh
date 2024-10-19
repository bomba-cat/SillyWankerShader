#version 120

varying vec2 TexCoords;
varying vec4 Color;

#define SELECTION_RED 2 // [0 1 2]
#define SELECTION_GREEN 0 // [0 1 2]
#define SELECTION_BLUE 1 // [0 1 2]
#define CUSTOM 0 // [0 1]
#define RGB_SPEED 0.05 // [0.01 0.05 0.1]

#include "/lib/random_color.glsl"

void main() {
    #if CUSTOM == 1
        vec3 Color = randomColor(RGB_SPEED);
    #elif CUSTOM == 0
        vec3 Color = vec3(SELECTION_RED, SELECTION_GREEN, SELECTION_BLUE);
    #endif

    gl_FragColor = vec4(Color, 1.0f);
}