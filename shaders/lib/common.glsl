/*
const int colortex0Format = RGB16F;
*/
/*
const int colortex1Format = RGB16F;
*/
/*
const int colortex2Format = RGB16F;
*/
/*
const int colortex5Format = RGB16F;
*/
/*
const int colortex7Format = RGB16F;
*/

#define SHADOW_ENABLED 1 // [0 1]
#define SHADOW_RESOLUTION 4096 // [512 1024 1536 2048 2560 3072 3584 4096 4608 8128]
#define SHADOW_QUALITY 2 // [1 2 3 4 5 6 7 8]
#define SHADOW_SOFTNESS 2 // [2 3 4 5 6 7 8]
#define SHADOW_NOISERESOLUTION 2048 // [8 216 512 1024 1536 2048 2560 3072 3584 4096 4608 8128]
//
#define SUN_PATHROTATION 40 // [-50 -45 -40 -35 -30 -25 -20 -15 -10 -5 0 5 10 15 20 25 30 35 40 45 50]
//
#define GODRAYS_ENABLED 1 // [0 1]
#define GODRAYS_SAMPLES 24 // [0 24 36]
//
#define TONEMAP_ENABLED 1 // [0 1]
#define TONEMAPPING 0 // [0 1]
//
#define MOTION_BLUR_ENABLED 1 // [0 1]
#define MAX_BLUR_AMOUNT 1.50 // [0.5 1.0 1.5] 
#define BLUR_SAMPLES 32 // [4 8 16 24 32 48 64]
#define EDGE_THRESHOLD 1.0
#define COLOR_INTENSITY 1.1
//
#define FULLBRIGHT 0 // [0 1]
//
#define BLOOM_ENABLED 0 // [0 1]

const bool shadowtex0Nearest = true;
const bool shadowtex1Nearest = true;
const bool shadowcolor0Nearest = true;
const float sunPathRotation = SUN_PATHROTATION;
const int noiseTextureResolution = SHADOW_NOISERESOLUTION;
const int shadowMapResolution = SHADOW_RESOLUTION;
const float waveHeight = 0.25;
const float waveSpeed = 0.05;
const float DEPTH_THRESHOLD = 0.66;
const vec3 blocklightColor = vec3(0.9451, 0.7294, 0.5373);
const vec3 skylightColor = vec3(0.05, 0.15, 0.3);
const vec3 sunlightColor = vec3(1.0, 0.9686, 0.8392);
const vec3 moonlightColor = vec3(0.8392, 0.9686, 1.0);
const vec3 ambientColor = vec3(0.025);
float exposure = 0.41;
float decay = 0.91;
float density = 1.25;
float gweight = 1.15;
vec3 earlyGodrayColor = vec3(1.0, 0.4157, 0.0);
vec3 godrayColor = vec3(0.9882, 0.6824, 0.4314);
vec3 moonrayColor = vec3(0.1608, 0.2941, 0.9608);
vec3 waterTint = vec3(0.1412, 0.7412, 1.0);
