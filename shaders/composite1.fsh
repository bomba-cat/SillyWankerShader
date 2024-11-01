#version 120

varying vec2 TexCoords;

uniform sampler2D colortex0;

void main(){
    vec4 Color = texture2D(colortex0, TexCoords).rgba;
    gl_FragColor = Color;
}
