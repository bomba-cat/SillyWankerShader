#version 120

varying vec2 TexCoords;
varying vec2 LightmapCoords;
varying vec3 Normal;
varying vec4 Color;

// The texture atlas
uniform sampler2D texture;

void main(){
    vec3 Color = vec3(1.0f);

    gl_FragColor = vec4(Color, 1.0f);
}