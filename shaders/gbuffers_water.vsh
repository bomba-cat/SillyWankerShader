#version 120

varying vec2 TexCoords;
varying vec2 LightmapCoords;
varying vec3 Normal;
varying vec4 Color;

uniform int frameCounter;
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform vec3 cameraPosition;

float rand(vec2 n) { 
return fract(sin(dot(n, vec2(12.9898, 4.1414))) * 43758.5453);
}

float noise(vec2 p){
vec2 ip = floor(p);
vec2 u = fract(p);
u = u*u*(3.0-2.0*u);

float res = mix(
mix(rand(ip),rand(ip+vec2(1.0,0.0)),u.x),
mix(rand(ip+vec2(0.0,1.0)),rand(ip+vec2(1.0,1.0)),u.x),u.y);
return res*res;
}

#define JUMPING_WATER 0 // [0 1]

void main() {
    vec4 position2 = gl_ModelViewMatrix * gl_Vertex;
    vec4 position = gbufferModelViewInverse * position2;

    position.y += sin(position2.z - position.z + (frameCounter / 25.0)) / 25.0; // Move vertices by 0.1 units along the y-axis
    position.y += sin(position2.x - position.x + (frameCounter / 15.0)) / 55.0; // Move vertices by 0.1 units along the y-axis

    #if JUMPING_WATER == 1
        position.y += length(sin((frameCounter) / 50.0) * sqrt(frameCounter)); // Move vertices by 0.1 units along the y-axis
    #endif

    // Set the transformed position
    gl_Position = gl_ProjectionMatrix * gbufferModelView * position; // Apply projection matrix to the modified position

    // Assign values to varying variables
    TexCoords = gl_MultiTexCoord0.st;
    LightmapCoords = mat2(gl_TextureMatrix[1]) * gl_MultiTexCoord1.st;
    LightmapCoords = (LightmapCoords * 33.05f / 32.0f) - (1.05f / 32.0f);
    Normal = gl_NormalMatrix * gl_Normal;
    Color = gl_Color;
}