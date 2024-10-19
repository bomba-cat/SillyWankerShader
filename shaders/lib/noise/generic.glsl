//erhm das isch nur pseudo random 🤓😒
float randomGeneric1(vec2 n) { 
    return fract(sin(dot(n, vec2(12.9898, 4.1414))) * 43758.5453);
}

float noiseGeneric1(vec2 p){
    vec2 ip = floor(p);
    vec2 u = fract(p);
    u = u*u*(3.0-2.0*u);


    float res = mix(mix(randomGeneric1(ip),randomGeneric1(ip+vec2(1.0,0.0)),u.x), mix(randomGeneric1(ip+vec2(0.0,1.0)),randomGeneric1(ip+vec2(1.0,1.0)),u.x),u.y);
    return res*res;
}

float randomGeneric2(in vec2 _st) {
    return fract(sin(dot(_st.xy, vec2(12.9898,78.233))) * 43758.5453123);
}