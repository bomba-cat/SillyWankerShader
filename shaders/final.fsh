#version 120

varying vec2 TexCoords;

uniform sampler2D colortex0;
uniform sampler2D colortex1;
uniform sampler2D colortex3;
uniform sampler2D sceneTexture;
uniform sampler2D gaux1;    // Screen-space coordinates for water

uniform int isEyeInWater;
uniform float viewWidth;
uniform float viewHeight;

uniform int frameCounter;
uniform float frameTime;

#define red_coefficient 1.0 // [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]
#define green_coefficient 1.0 // [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]
#define blue_coefficient 1.0 // [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]
#define SHARPNESS 0 // [0 1]
#define AA 0 // [0 1]
#define ROTATING_SCREEN 0 // [0 1]

#include "/lib/anti_aliasing/taa.glsl"
#include "/lib/palettize_colors.glsl"
#include "/lib/pixel_sorting.glsl"
#include "/lib/rotate_screen.glsl"

float brightness(vec3 color) {
    return dot(color, vec3(0.299, 0.587, 0.114)); // Luminance formula for brightness
}

void main() {
    vec2 finalTexCoords = TexCoords;

    #if ROTATING_SCREEN == 1
        finalTexCoords = transformTexCoords();
    #endif

    // Sample and apply gamma correction
    vec3 Color = pow(texture2D(colortex0, finalTexCoords).rgb, vec3(1.0f / 2.2f));

    Color *= vec3(red_coefficient, green_coefficient, blue_coefficient);

    vec4 waterScreenSpaceCoords = texture2D(gaux1, TexCoords);

    if (waterScreenSpaceCoords.a == 1) {
        vec2 inversePosition = clamp(vec2(TexCoords.x, 1.0 - TexCoords.y), 0.0, 1.0);
        vec3 reflectionColor = texture2D(colortex0, inversePosition).rgb;
        float reflectionFactor = smoothstep(0.0, 1.0, brightness(reflectionColor));

        Color = mix(Color, reflectionColor, reflectionFactor);

        //0.5 + (0.5 - TexCoords.y)
    }

    // Palettize Colors
    #if color_amount > 0
        Color = findClosestColor(Color);
    #endif

    #if SHARPNESS == 1
        Color = sharpen(colortex0, Color, finalTexCoords);
    #endif

    #if AA == 1
        Color = fast_taa(Color, finalTexCoords);
    #endif

    //https://www.shadertoy.com/view/NdKyz1
    vec2 iResolution = vec2(viewWidth, viewHeight);

    vec2 uv = finalTexCoords / iResolution;

    float X = uv.x*25.+frameTime;
    float Y = uv.y*25.+frameTime;
    uv.y += cos(X+Y)*0.005*cos(Y);
    uv.x += sin(X-Y)*0.005*sin(Y);

    if (isEyeInWater == 1) {
        gl_FragColor = texture(colortex0,uv) * vec4(0.2,0.4,.9,1.);
    }

    gl_FragColor = vec4(Color, 1.0f);
}
