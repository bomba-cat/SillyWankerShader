#version 120

varying vec2 TexCoords;
varying vec2 LightmapCoords;
varying vec3 Normal;
varying vec4 Color;

// The texture atlas
uniform sampler2D texture;

#define RAINBOW_CLOUDS = 0 // [0 1]

#include "/lib/noise/random_color.glsl"

void main(){
    #if RAINBOW_CLOUDS == 1
      vec3 color = randomColor(0.01);
    #else
      vec3 color = Color.rgb
    #endif

    // gl_FragColor = Color;    // For debugging
    gl_FragColor = vec4(vec3(color), 1.0f);
}
