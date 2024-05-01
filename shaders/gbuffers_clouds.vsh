#version 120

varying vec2 TexCoords;
varying vec2 LightmapCoords;
varying vec3 Normal;
varying vec4 Color;

uniform int frameCounter;
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform vec3 cameraPosition;

#define WORLD_CURVED 0 // [0 1]
#define CURVE_STRENGHT 0.09 // [0.5 0.1 0.09 0.09 0.07 0.06 0.05 0.04 0.03 0.02 0.01]

void main() {
    // Took half an hour to figure, even tho we had it since the beginning in here
    vec4 newPosition = gl_Vertex;

    vec4 newPositionInv = gl_ModelViewMatrix * newPosition;
    vec4 newPositionModel = gbufferModelViewInverse  * newPositionInv;

    #if WORLD_CURVED == 1
        newPositionModel.y += pow(CURVE_STRENGHT*newPosition.z, 2);
        newPositionModel.y += pow(CURVE_STRENGHT*newPosition.x, 2);
    #endif

    gl_Position = gl_ProjectionMatrix * gbufferModelView * newPositionModel;

    TexCoords = gl_MultiTexCoord0.st;
    LightmapCoords = mat2(gl_TextureMatrix[1]) * gl_MultiTexCoord1.st;
    LightmapCoords = (LightmapCoords * 33.05f / 32.0f) - (1.05f / 32.0f);
    Normal = gl_NormalMatrix * gl_Normal;
    Color = gl_Color;
}