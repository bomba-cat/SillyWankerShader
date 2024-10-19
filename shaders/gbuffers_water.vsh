#version 120

varying vec2 TexCoords;
varying vec2 LightmapCoords;
varying vec3 Normal;
varying vec4 Color;

uniform int frameCounter;
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform vec3 cameraPosition;

#define WAVE_TYPE 2 // [0 1 2 3]
#define JUMPING_WATER 0 // [0 1]
#define WAVE_SPEED 1.0 // [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]
#define WAVE_DIVIDER 1.0 // [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0]

#define WORLD_CURVED 0 // [0 1]
#define CURVE_STRENGHT 0.09 // [0.5 0.1 0.09 0.09 0.07 0.06 0.05 0.04 0.03 0.02 0.01]

#include "/lib/noise/generic.glsl"

void main() {
    vec4 newPosition = gl_Vertex; // Start with the original position
    float jumpOffset = 0.0f;

    #if JUMPING_WATER == 1
        jumpOffset = length(sin(frameCounter / 50.0 * WAVE_SPEED) * sqrt(frameCounter)); // Move vertices by 0.1 units along the y-axis
    #endif

    // Wave Types
    #if WAVE_TYPE == 0
        //Flat Animated
        newPosition.y += sin(frameCounter / 50.0 * WAVE_SPEED) / (40.0 * WAVE_DIVIDER ) - 0.05 + jumpOffset;
    #elif WAVE_TYPE == 1
        //Waves
        vec4 newPositionInv = gl_ModelViewMatrix * newPosition;
        vec4 newPositionModel = gbufferModelViewInverse  * newPositionInv;

        newPositionModel.y += sin(newPositionInv.z - newPositionModel.z + frameCounter / 25.0 * WAVE_SPEED) / (25.0 * WAVE_DIVIDER);
        newPositionModel.y += sin(newPositionInv.x - newPositionModel.x + frameCounter / 15.0 * WAVE_SPEED) / (55.0 * WAVE_DIVIDER) + jumpOffset;

        #if WORLD_CURVED == 1
            newPositionModel.y += pow(CURVE_STRENGHT*newPosition.z, 2);
            newPositionModel.y += pow(CURVE_STRENGHT*newPosition.x, 2);
        #endif

    #elif WAVE_TPYE == 2
        //Vanilla
        newPosition.y += jumpOffset;
    #elif WAVE_TYPE == 3
        //noiseGeneric1
        newPosition.y += noiseGeneric1(sin(vec2(newPosition.x + sin(frameCounter / 15.0),newPosition.z + sin(frameCounter / 25.0)) + frameCounter / 25.0) / 3.1) - 0.035;
    #endif

    #if WAVE_TYPE == 1
        gl_Position = gl_ProjectionMatrix * gbufferModelView * newPositionModel;
    #else
        gl_Position = gl_ModelViewProjectionMatrix * newPosition;
    #endif
    // Set the transformed position
    // Assign values to varying variables
    TexCoords = gl_MultiTexCoord0.st;
    LightmapCoords = mat2(gl_TextureMatrix[1]) * gl_MultiTexCoord1.st;
    LightmapCoords = (LightmapCoords * 33.05f / 32.0f) - (1.05f / 32.0f);
    Normal = gl_NormalMatrix * gl_Normal;
    Color = gl_Color;
}
