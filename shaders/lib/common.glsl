/*
const int colortex0Format = RGB16F;
*/
/*
const int colortex1Format = RGB16F;
*/
/*
const int colortex2Format = RGB16F;
*/

#define SHADOW_RESOLUTION 4096 // [512 1024 1536 2048 2560 3072 3584 4096 4608 8128]
#define SHADOW_QUALITY 2 // [1 2 3 4 5 6 7 8]
#define SHADOW_SOFTNESS 2 // [2 3 4 5 6 7 8]
//
#define SUNPATHROTATION 40 // [-50 -45 -40 -35 -30 -25 -20 -15 -10 -5 0 5 10 15 20 25 30 35 40 45 50]

const bool shadowtex0Nearest = true;
const bool shadowtex1Nearest = true;
const bool shadowcolor0Nearest = true;
const float sunPathRotation = SUNPATHROTATION;
const int noiseTextureResolution = 2048;
const int shadowMapResolution = SHADOW_RESOLUTION;
