float rotationAngle = frameCounter/100.0;

vec2 transformTexCoords() {
    vec2 rotatedCoords;

    // Compute the center of the texture
    vec2 center = vec2(0.5, 0.5); // Assuming TexCoords are in the range [0, 1]

    // Translate coordinates to center, rotate, then translate back
    vec2 translatedCoords = TexCoords - center; // Translate to origin

    // Apply rotation using a 2D rotation matrix
    rotatedCoords.x = translatedCoords.x * cos(rotationAngle) - translatedCoords.y * sin(rotationAngle);
    rotatedCoords.y = translatedCoords.x * sin(rotationAngle) + translatedCoords.y * cos(rotationAngle);

    // Translate back to the original texture space
    rotatedCoords += center;

    return rotatedCoords;
}