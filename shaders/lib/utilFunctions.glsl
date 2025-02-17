//Interleaved Gradient Noise Calculations
float IGN(vec2 coord)
{
    return fract(52.9829189f * fract(0.06711056f * coord.x + 0.00583715f* coord.y));
}

float IGN(vec2 coord, int frame)
{
    return  IGN(coord + 5.588238 * (frame & 63));
}

//conversion of screenspace to view space
vec3 viewSpaceToScreenSpace(vec3 viewPosition) {
	vec3 screenPosition  = vec3(gbufferProjection[0].x, gbufferProjection[1].y, gbufferProjection[2].z) * viewPosition + gbufferProjection[3].xyz;
	     screenPosition /= -viewPosition.z;

	return screenPosition * 0.5 + 0.5;
}
float viewSpaceToScreenSpace(float depth, mat4 projection) {
	return ((projection[2].z * depth + projection[3].z) / -depth) * 0.5 + 0.5;
}