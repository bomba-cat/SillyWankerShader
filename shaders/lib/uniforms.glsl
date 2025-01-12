#ifndef UNIFORMS_GLSL
#define UNIFORMS_GLSL

uniform sampler2D gcolor;       //0

uniform sampler2D gdepth;       //1

uniform sampler2D gnormal;      //2

uniform sampler2D composite;    //3

uniform sampler2D gaux1;        //7

uniform sampler2D gaux2;        //8

uniform sampler2D gaux3;        //9

uniform sampler2D gaux4;        //10

uniform sampler2D colortex0;    //0

uniform sampler2D colortex1;    //1

uniform sampler2D colortex2;    //2

uniform sampler2D colortex3;    //3

uniform sampler2D colortex4;    //7

uniform sampler2D colortex5;    //8

uniform sampler2D colortex6;    //9

uniform sampler2D colortex7;    //10

uniform sampler2D colortex8;    //16

uniform sampler2D colortex9;    //17

uniform sampler2D colortex10;   //18

uniform sampler2D colortex11;   //19

uniform sampler2D colortex12;   //20

uniform sampler2D colortex13;   //21

uniform sampler2D colortex14;   //22

uniform sampler2D colortex15;   //23

uniform sampler2D watershadow;  //4

uniform sampler2D shadowtex0;   //4

uniform sampler2D shadowtex1;   //5

uniform sampler2D gdepthtex;    //6

uniform sampler2D depthtex0;    //6

uniform sampler2D depthtex1;    //11

uniform sampler2D depthtex2;    //12

uniform sampler2D shadowcolor;  //13

uniform sampler2D shadowcolor0; //13

uniform sampler2D shadowcolor1; //14

uniform sampler2D noisetex;     //15

uniform sampler2D lightmap; //1

uniform sampler2D normals;

uniform sampler2D specular; //3

uniform sampler2D shadow; //waterShadowEnabled ? 5 : 4

uniform int heldItemId; //held item ID (main hand), used only for items defined in item.properties

uniform int heldBlockLightValue; //held item light value (main hand)

uniform int heldItemId2; //held item ID (off hand), used only for items defined in item.properties

uniform int heldBlockLightValue2; //held item light value (off hand)

uniform int fogMode; //GL_LINEAR, GL_EXP or GL_EXP2

uniform float fogDensity; //0.0-1.0

uniform vec3 fogColor; //r, g, b

uniform vec3 skyColor; //r, g, b

uniform int worldTime; //<ticks> = worldTicks % 24000

uniform int worldDay; //<days> = worldTicks / 24000

uniform int moonPhase; //0-7

uniform int frameCounter; //Frame index (0 to 720719, then resets to 0)

uniform float frameTime; //last frame time, seconds

uniform float frameTimeCounter; //run time, seconds (resets to 0 after 3600s)

uniform float sunAngle; //0.0-1.0

uniform float shadowAngle; //0.0-1.0

uniform float rainStrength; //0.0-1.0

uniform float aspectRatio; //viewWidth / viewHeight

uniform float viewWidth; //viewWidth

uniform float viewHeight; //viewHeight

uniform float near; //near viewing plane distance

uniform float far; //far viewing plane distance

uniform vec3 sunPosition; //sun position in eye space

uniform vec3 moonPosition; //moon position in eye space

uniform vec3 shadowLightPosition; //shadow light (sun or moon) position in eye space

uniform vec3 upPosition; //direction up

uniform vec3 cameraPosition; //camera position in world space

uniform vec3 previousCameraPosition; //last frame cameraPosition

uniform mat4 gbufferModelView; //modelview matrix after setting up the camera transformations

uniform mat4 gbufferModelViewInverse; //inverse gbufferModelView

uniform mat4 gbufferPreviousModelView; //last frame gbufferModelView

uniform mat4 gbufferProjection; //projection matrix when the gbuffers were generated

uniform mat4 gbufferProjectionInverse; //inverse gbufferProjection

uniform mat4 gbufferPreviousProjection; //last frame gbufferProjection

uniform mat4 shadowProjection; //projection matrix when the shadow map was generated

uniform mat4 shadowProjectionInverse; //inverse shadowProjection

uniform mat4 shadowModelView; //modelview matrix when the shadow map was generated

uniform mat4 shadowModelViewInverse; //inverse shadowModelView

uniform float wetness; //rainStrength smoothed with wetnessHalfLife or drynessHalfLife

uniform float eyeAltitude; //view entity Y position

uniform ivec2 eyeBrightness; //x = block brightness, y = sky brightness, light 0-15 = brightness 0-240

uniform ivec2 eyeBrightnessSmooth; //eyeBrightness smoothed with eyeBrightnessHalflife

uniform ivec2 terrainTextureSize; //not used

uniform int terrainIconSize; //not used

uniform int isEyeInWater; //1 = camera is in water, 2 = camera is in lava, 3 = camera is in powdered snow

uniform float nightVision; //night vision (0.0-1.0)

uniform float blindness; //blindness (0.0-1.0)

uniform float screenBrightness; //screen brightness (0.0-1.0)

uniform int hideGUI; //GUI is hidden

uniform float centerDepthSmooth; //centerDepth smoothed with centerDepthSmoothHalflife

uniform ivec2 atlasSize; //texture atlas size (only set when the atlas texture is bound)

uniform vec4 spriteBounds; //sprite bounds in the texture atlas (u0, v0, u1, v1), set when MC_ANISOTROPIC_FILTERING is enabled

uniform vec4 entityColor; //entity color multiplier (entity hurt, creeper flashing when exploding)

uniform int entityId; //entity ID

uniform int blockEntityId; //block entity ID (block ID for the tile entity, only for blocks specified in block.properties)

uniform ivec4 blendFunc; //blend function (srcRGB, dstRGB, srcAlpha, dstAlpha)

uniform int instanceId; //instance ID when instancing is enabled (countInstances > 1), 0 = original, 1-N = copies

uniform float playerMood; //player mood (0.0-1.0), increases the longer a player stays underground

uniform int renderStage; //render stage

uniform mat4 modelViewMatrix; //model view matrix

uniform mat4 modelViewMatrixInverse; //modelViewMatrixInverse

uniform mat4 projectionMatrix; //projectionMatrix

uniform mat4 projectionMatrixInverse; //projectionMatrixInverse

uniform mat4 textureMatrix = mat4(1.0); //textureMatrix = mat4(1.0)

uniform mat3 normalMatrix; //normal matrix

uniform vec3 chunkOffset; //terrain chunk origin, used with attribute vaPosition

uniform float alphaTestRef; //alpha test reference value, the check is if (color.a < alphaTestRef)

uniform float darknessFactor; //strength of the darkness effect (0.0-1.0)

uniform float darknessLightFactor; //lightmap variations caused by the darkness effect (0.0-1.0)

uniform sampler2D tex;//0

uniform sampler2D texture;

#endif
