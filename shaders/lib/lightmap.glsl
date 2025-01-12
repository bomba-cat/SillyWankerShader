#ifndef LIGHTMAP_GLSL
#define LIGHTMAP_GLSL

vec4 fsh_get_lightmap(vec2 LightmapCoords)
{
  return vec4(LightmapCoords, 0.0f, 1.0f);
}

vec2 vsh_get_lightmap()
{
  vec2 lightmapCoords = mat2(gl_TextureMatrix[1]) * gl_MultiTexCoord1.st;
  return (lightmapCoords * 33.05f / 32.0f) - (1.05f / 32.0f);
}

float AdjustLightmapTorch(float torch)
{
  const float K = 2.0f;
  const float P = 5.06;
  return K * pow(torch, P);
}

float AdjustLightmapSky(float sky)
{
  float sky_2 = sky * sky;
  return sky_2 * sky_2;
}

vec2 AdjustLightmap(vec2 Lightmap)
{
  vec2 NewLightMap;
  NewLightMap.x = AdjustLightmapTorch(Lightmap.x);
  NewLightMap.y = AdjustLightmapSky(Lightmap.y);
  return NewLightMap;
}

vec3 GetLightmapColor(vec2 Lightmap)
{
  Lightmap = AdjustLightmap(Lightmap);
  
  const vec3 TorchColor = vec3(1.0f, 0.25f, 0.08f);
  const vec3 SkyColor = vec3(0.05f, 0.15f, 0.3f);

  vec3 TorchLighting = Lightmap.x * TorchColor;
  vec3 SkyLighting = Lightmap.y * SkyColor;

  vec3 LightmapLighting = TorchLighting + SkyLighting;

  return LightmapLighting;
}

#endif
