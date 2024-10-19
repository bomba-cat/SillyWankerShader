#version 120

varying vec2 TexCoords;
varying vec2 LightmapCoords;
varying vec3 Normal;
varying vec4 Color;

uniform sampler2D texture;
uniform sampler2D colortex0;

#include "/lib/noise/simplex_noise.glsl"

void main() {
    float noise_val = snoise(5*vec2(TexCoords.x, TexCoords.y));
    // Sample and apply gamma correction
    vec3 Color = texture2D(colortex0, TexCoords).rgb;
    vec4 Corrected = vec4(Color.rgb, noise_val*0.5+0.5);

    /* DRAWBUFFERS:012 */
    // Write the values to the color textures
    gl_FragData[0] = Corrected;
    gl_FragData[1] = vec4(Normal * 0.5f + 0.5f, 1.0f);
    gl_FragData[2] = vec4(LightmapCoords, 0.0f, 1.0f);
}