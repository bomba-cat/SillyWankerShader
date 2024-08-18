#version 120

varying vec2 TexCoords;
uniform int isEyeInWater;
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

void main() {
   vec4 newPosition = gl_Vertex;

   if (isEyeInWater == 1) {
      newPosition.y += noise(sin(vec2(newPosition.x + sin(frameCounter),newPosition.z + sin(frameCounter)) + frameCounter));

      newPosition.x += noise(sin(vec2(newPosition.y + sin(frameCounter),newPosition.z + sin(frameCounter)) + frameCounter));
   }

   gl_Position = gl_ModelViewProjectionMatrix * newPosition;
   TexCoords = gl_MultiTexCoord0.st;
}