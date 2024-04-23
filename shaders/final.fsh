#version 120

varying vec2 TexCoords;

uniform sampler2D colortex0;

#define red_coefficient 1.0 // [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]
#define green_coefficient 1.0 // [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]
#define blue_coefficient 1.0 // [0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]

void main() {
    // Sample and apply gamma correction
   vec3 Color = pow(texture2D(colortex0, TexCoords).rgb, vec3(1.0f / 2.2f));
   Color = Color * vec3(red_coefficient, green_coefficient, blue_coefficient);
   gl_FragColor = vec4(Color, 1.0f);
}