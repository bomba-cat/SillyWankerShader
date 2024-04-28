#version 120

varying vec2 TexCoords;

uniform sampler2D colortex0;
uniform sampler2D colortex1;
uniform sampler2D colortex3;

#define red_coefficient 1.0 // [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]
#define green_coefficient 1.0 // [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]
#define blue_coefficient 1.0 // [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]
#define SHARPNESS 0 // [0 1]
#define AA 0 // [0 1]
#define color_amount 0 // [0 1 2 3 4]

#if color_amount > 0
    #if color_amount == 1
        const int palette_len = 5;
        const vec3 paletteColors[5] = vec3[5](
            vec3(1.0, 0.0, 0.0),
            vec3(0.0, 1.0, 0.0),
            vec3(0.0, 0.0, 1.0),
            vec3(1.0, 1.0, 0.0),
            vec3(1.0, 0.0, 1.0)
        );
    #elif color_amount == 2
        const int palette_len = 11;
        const vec3 paletteColors[10] = vec3[10](
            vec3(0.9, 0.1, 0.1),    // Red
            vec3(0.1, 0.9, 0.1),    // Green
            vec3(0.1, 0.1, 0.9),    // Blue
            vec3(0.9, 0.9, 0.1),    // Yellow
            vec3(0.9, 0.1, 0.9),    // Magenta
            vec3(0.1, 0.9, 0.9),    // Cyan
            vec3(0.9, 0.5, 0.1),    // Orange
            vec3(0.1, 0.9, 0.5),    // Lime
            vec3(0.1, 0.5, 0.9),    // Sky Blue
            vec3(0.5, 0.1, 0.9)     // Purple
        );
    #elif color_amount == 3
        const int palette_len = 16;
        const vec3 paletteColors[16] = vec3[16](
            vec3(1.0, 0.0, 0.0),
            vec3(0.0, 1.0, 0.0),
            vec3(0.0, 0.0, 1.0),
            vec3(1.0, 1.0, 0.0),
            vec3(1.0, 0.0, 1.0),
            vec3(0.0, 1.0, 1.0),
            vec3(1.0, 1.0, 1.0),
            vec3(0.0, 0.0, 0.0),
            vec3(0.5, 0.5, 0.5),
            vec3(0.5, 0.0, 0.0),
            vec3(0.0, 0.5, 0.0),
            vec3(0.0, 0.0, 0.5),
            vec3(0.5, 0.5, 0.0),
            vec3(0.5, 0.0, 0.5),
            vec3(0.0, 0.5, 0.5),
            vec3(0.5, 0.5, 0.5)
        );
    #elif color_amount == 4
        const int palette_len = 36;
        const vec3 paletteColors[36] = vec3[36](
            vec3(1.0, 0.0, 0.0),    // Red
            vec3(0.3, 0.9, 0.3),    // Green
            vec3(0.0, 0.0, 1.0),    // Blue
            vec3(1.0, 1.0, 0.1),    // Yellow
            vec3(1.0, 0.0, 1.0),    // Magenta
            vec3(0.0, 1.0, 1.0),    // Cyan
            vec3(0.7, 0.3, 0.3),    // Orange
            vec3(0.5, 1.0, 0.0),    // Lime
            vec3(0.0, 0.5, 1.0),    // Sky Blue
            vec3(1.0, 0.0, 0.5),    // Purple
            vec3(0.5, 0.0, 1.0),    // Violet
            vec3(1.0, 0.5, 0.5),    // Salmon
            vec3(0.5, 1.0, 0.5),    // Mint
            vec3(0.5, 0.5, 1.0),    // Cornflower Blue
            vec3(1.0, 1.0, 0.5),    // Lemon
            vec3(1.0, 0.5, 1.0),    // Orchid
            vec3(0.5, 1.0, 1.0),    // Turquoise
            vec3(1.0, 0.75, 0.5),   // Apricot
            vec3(0.5, 1.0, 0.75),   // Lime Green
            vec3(0.75, 0.5, 1.0),   // Lavender
            vec3(0.6, 0.3, 0.0),   // Coral
            vec3(0.75, 1.0, 0.5),   // Chartreuse
            vec3(0.5, 0.75, 1.0),   // Periwinkle
            vec3(1.0, 0.75, 0.75),  // Peach
            vec3(0.75, 1.0, 0.75),  // Mint Green
            vec3(0.75, 0.75, 1.0),  // Powder Blue
            vec3(0.8, 0.8, 0.75),   // Banana
            vec3(1.0, 0.75, 1.0),   // Rose
            vec3(0.75, 1.0, 1.0),   // Aquamarine
            vec3(1.0, 0.9, 0.7),    // Cantaloupe
            vec3(0.7, 1.0, 0.9),    // Seafoam Green
            vec3(0.9, 0.7, 1.0),    // Lilac
            vec3(1.0, 0.7, 0.9),     // Salmon Pink
            vec3(0.1,0.0,0.0),
            vec3(0.3,0.0,0.1),
            vec3(0.1,0.2,0.3)
        );

    #endif
#endif

uniform float pixel_size_x;
uniform float pixel_size_y;

#include "/lib/taa.glsl"

vec3 findClosestColor(vec3 currentColor) {
    float minDistance = distance(currentColor, paletteColors[0]);
    vec3 closestColor = paletteColors[0];

    for (int i = 1; i < palette_len; i++) { // Adjust this loop limit according to your palette size
        float dist = distance(currentColor, paletteColors[i]);
        if (dist < minDistance) {
            minDistance = dist;
            closestColor = paletteColors[i];
        }
    }

    return closestColor;
}

void main() {
    // Sample and apply gamma correction
    vec3 Color = pow(texture2D(colortex0, TexCoords).rgb, vec3(1.0f / 2.2f));

    Color *= vec3(red_coefficient, green_coefficient, blue_coefficient);

    #if color_amount > 0
        Color = findClosestColor(Color);
    #endif

    #if SHARPNESS == 1
        Color = sharpen(colortex0, Color, TexCoords);
    #endif

    #if AA == 1
        Color = fast_taa(Color, TexCoords);
    #endif

    gl_FragColor = vec4(Color, 1.0f);
}