#version 120

varying vec2 TexCoords;

uniform sampler2D colortex0;
uniform sampler2D colortex1;
uniform sampler2D colortex3;

uniform float pixel_size_x;
uniform float pixel_size_y;

uniform int isEyeInWater;
uniform float frameTime;
uniform float viewWidth;
uniform float viewHeight;

#define red_coefficient 1.0 // [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]
#define green_coefficient 1.0 // [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]
#define blue_coefficient 1.0 // [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]
#define SHARPNESS 0 // [0 1]
#define AA 0 // [0 1]

#include "/lib/anti_aliasing/taa.glsl"
#include "/lib/palettize_colors.glsl"

void main() {
    // Sample and apply gamma correction
    vec3 Color = pow(texture2D(colortex0, TexCoords).rgb, vec3(1.0f / 2.2f));

    Color *= vec3(red_coefficient, green_coefficient, blue_coefficient);

    // Palettize Colors
    #if color_amount > 0
        Color = findClosestColor(Color);
    #endif

    #if SHARPNESS == 1
        Color = sharpen(colortex0, Color, TexCoords);
    #endif

    #if AA == 1
        Color = fast_taa(Color, TexCoords);
    #endif

    //https://www.shadertoy.com/view/NdKyz1
    vec2 iResolution = vec2(viewWidth, viewHeight);

    vec2 uv = TexCoords / iResolution;

    float X = uv.x*25.+frameTime;
    float Y = uv.y*25.+frameTime;
    uv.y += cos(X+Y)*0.005*cos(Y);
    uv.x += sin(X-Y)*0.005*sin(Y);

    if (isEyeInWater == 1) {
        gl_FragColor = texture(colortex0,uv) * vec4(0.2,0.4,.9,1.);
    }

    gl_FragColor = vec4(Color, 1.0f);
}
