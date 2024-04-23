#version 120

varying vec2 TexCoords;

uniform sampler2D colortex0;
uniform sampler2D colortex1;
uniform sampler2D colortex3;

#define red_coefficient 1.0 // [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]
#define green_coefficient 1.0 // [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]
#define blue_coefficient 1.0 // [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]
#define SHARPNESS 0 // [0 1]

uniform float pixel_size_x;
uniform float pixel_size_y;

#include "/lib/taa.glsl"

void main() {
    // Sample and apply gamma correction
    vec3 Color = pow(texture2D(colortex0, TexCoords).rgb, vec3(1.0f / 2.2f));
    Color = Color * vec3(red_coefficient, green_coefficient, blue_coefficient);
    #if SHARPNESS == 1
        Color = sharpen(colortex0, Color, TexCoords);
    #endif
    // Color = fast_taa(Color, TexCoords);
    gl_FragColor = vec4(Color, 1.0f);
}