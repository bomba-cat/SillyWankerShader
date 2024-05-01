#version 120

varying vec2 TexCoords;
varying vec2 LightmapCoords;
varying vec3 Normal;
varying vec4 Color;

// The texture atlas
uniform sampler2D texture;

#include "lib/random_color.glsl"

void main(){
    vec3 color = randomColor(0.01);

    // gl_FragColor = Color;    // For debugging
    gl_FragColor = vec4(vec3(color), 1.0f);
}