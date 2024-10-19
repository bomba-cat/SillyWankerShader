#version 120

varying vec2 TexCoords;
varying vec4 Color;
uniform sampler2D colortex0;

uniform float viewWidth;
uniform float viewHeight;
uniform float frameTime;
uniform int frameCounter;

vec2 u_resolution = vec2(viewWidth, viewHeight);
float u_time = frameTime;

#include "/lib/noise/generic.glsl"
#include "/lib/noise/truchet_pattern.glsl"

#define GLINT_TYPE 4 // [0 1 2 3 4 5 6]
#define GLINT_SPEED 1 // [1 2 3 4 5 6 7 8 9 10]
#define GLINT_RED 1 // [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1]
#define GLINT_GREEN 1 // [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1]
#define GLINT_BLUE 1 // [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1]

void main() {
    vec2 st = (gl_FragCoord.xy + frameCounter * GLINT_SPEED)/u_resolution.xy;
    st *= 10.0;
    // st = (st-vec2(5.0))*(abs(sin(u_time*0.2))*5.);
    // st.x += u_time*3.0;

    vec2 ipos = floor(st);  // integer
    vec2 fpos = fract(st);  // fraction

    vec2 tile = truchetPattern(fpos, randomGeneric2( ipos ));

    float color = 0.0;

    #if GLINT_TYPE == 1
        // Maze
        color = smoothstep(tile.x-0.3,tile.x,tile.y)-
                smoothstep(tile.x,tile.x+0.3,tile.y);
    #elif GLINT_TYPE == 2
        // Circles
        color = (step(length(tile),0.6) -
                step(length(tile),0.4) ) +
                (step(length(tile-vec2(1.)),0.6) -
                step(length(tile-vec2(1.)),0.4) );
    #elif GLINT_TYPE == 3
        // Truchet (2 triangles)
        color = step(tile.x,tile.y);
    #elif GLINT_TYPE == 4
        //Linear Fade
        color = randomGeneric2(vec2(TexCoords.x)/((6000+frameCounter)*GLINT_SPEED));

    #elif GLINT_TYPE == 5
        //Square
        color = 0.5 * randomGeneric2(vec2(TexCoords.x)/((6000+frameCounter)*GLINT_SPEED)) + 0.5 * randomGeneric2(vec2(TexCoords.y/((6000+frameCounter)*GLINT_SPEED)));

    #elif GLINT_TYPE == 6
        //Fade in/out
        color = (length(sin(mod((frameCounter)/30.0, 180.0)*GLINT_SPEED)) * 0.5 + 0.5);
    #else
        gl_FragColor = vec4(vec3(Color.r * GLINT_RED, Color.g * GLINT_GREEN, Color.b * GLINT_BLUE), 1.0f);
    #endif

    #if GLINT_TYPE > 0
        gl_FragColor = vec4(vec3(color * GLINT_RED, color * GLINT_GREEN, color * GLINT_BLUE),1.0);
    #endif
}