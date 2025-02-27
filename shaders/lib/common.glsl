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
#define SHADOW_RESOLUTION 4608 // [512 1024 1536 2048 2560 3072 3584 4096 4608 8128]
#define SHADOW_QUALITY 2 // [1 2 3 4 5 6 7 8]
#define SHADOW_SOFTNESS 2 // [2 3 4 5 6 7 8]
#define SHADOW_NOISERESOLUTION 8128 // [8 216 512 1024 1536 2048 2560 3072 3584 4096 4608 8128]
//
#define SUN_PATHROTATION 40 // [-50 -45 -40 -35 -30 -25 -20 -15 -10 -5 0 5 10 15 20 25 30 35 40 45 50]
//
#define GODRAYS_ENABLED 1 // [0 1]
#define GODRAYS_SAMPLES 36 // [12 24 36]
//
#define TONEMAP_ENABLED 1 // [0 1]
#define TONEMAPPING 1 // [0 1]
//
#define MOTION_BLUR_ENABLED 1 // [0 1]
#define MAX_BLUR_AMOUNT 1.0 // [0.5 1.0 1.5] 
#define BLUR_SAMPLES 64 // [4 8 16 24 32 48 64]
#define EDGE_THRESHOLD 1.0 // [0.25 0.5 0.75 1.0]
#define COLOR_INTENSITY 1.0 // [0.5 0.75 1.0 1.25 1.5]
//
#define FULLBRIGHT 0 // [0 1]
//
#define BLOOM_ENABLED 1 // [0 1]
#define BLOOM_RADIUS 5.0 // [2.0 2.5 3.0 3.5 4.0 4.5 5.0 5.5]
#define BLOOM_THRESHOLD 0.87 // [0.25 0.5 0.75 0.87 1]
//
#define SUN_ILLUMINANCE 1 
#define MOON_ILLUMINANCE 1
//
#define SELECT_RED 0
#define SELECT_GREEN 0 
#define SELECT_BLUE 0

const bool shadowtex0Nearest = true;
const bool shadowtex1Nearest = true;
const bool shadowcolor0Nearest = true;

const float sunPathRotation = SUN_PATHROTATION;
const int noiseTextureResolution = SHADOW_NOISERESOLUTION;
const int shadowMapResolution = SHADOW_RESOLUTION;

const float waveHeight = 0.25;
const float waveSpeed = 0.05;

const float DEPTH_THRESHOLD = 0.66;

vec3 blocklightColor = vec3(0.85, 0.42, 0.12);
vec3 skylightColor = vec3(0.10, 0.15, 0.22);
vec3 sunlightColor = vec3(0.85, 0.92, 1.0);
vec3 morningSunlightColor = vec3(0.80, 0.55, 0.35);
vec3 moonlightColor = vec3(0.45, 0.55, 1.0);  
vec3 nightSkyColor = vec3(0.06, 0.12, 0.45);
vec3 morningSkyColor = vec3(0.65, 0.55, 0.38);
vec3 ambientColor = vec3(0.08, 0.08, 0.08);
vec3 nightBlockColor = vec3(0.10, 0.09, 0.07);
vec3 nightAmbientColor = vec3(0.06, 0.06, 0.06);
vec3 duskSunlightColor = vec3(0.85, 0.40, 0.35);
vec3 duskSkyColor = vec3(0.75, 0.45, 0.38);

float exposure = 0.41;
float decay = 0.91;
float density = 1.25;
float gweight = 1.15;

vec3 earlyGodrayColor = vec3(1.0, 0.2353, 0.0627);
vec3 duskGodrayColor = vec3(1.0, 0.0667, 0.0);
vec3 godrayColor = vec3(0.9882, 0.6824, 0.4314);
vec3 moonrayColor = vec3(0.1608, 0.2941, 0.9608);
vec3 rainGodrayColor = vec3(0.5882, 0.5882, 0.5882);
vec3 waterTint = vec3(0.0, 0.0667, 1.0);
