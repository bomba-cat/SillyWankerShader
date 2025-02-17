vec3 doGodrays( vec3 color) {
	#if GODRAYS_ENABLE ==1
	color = vec3(0);

    //alternate texcoord position
	vec2 altCoord = texcoord;

	//convert the sun to viewspace using the shadowLight position
	vec3 LightVector = viewSpaceToScreenSpace(shadowLightPosition);
	LightVector.xy = clamp(LightVector.xy, vec2(-0.5), vec2(1.5)); // we want to clamp this value to make sure nothing funky happens
	
    //create a delta texcoord that reads from the sun position
	vec2 deltaTexCoord = (texcoord - (LightVector.xy)); 

	//calculates the density based off the godray samples
	deltaTexCoord *= 1.0 / float(GODRAYS_SAMPLES) * density;
	
    //base sunlight decay
    float illuminationDecay = 1.0;

    //set the altCoord to the deltaTexCoord and mutliply it by the interleaved gradient noise for cleaner results
	altCoord -= deltaTexCoord * IGN(floor(gl_FragCoord.xy), frameCounter);
	
    //Sample the godrays
	for(int i = 0; i < GODRAYS_SAMPLES; i++)
	{
			 //final sample sent through the depth map
             vec3 samples = texture(depthtex0, altCoord).r == 1.0 ? vec3(1.0) * godrayColor : vec3(0.0);
			//alternate time frames to account for various conditions
            if (worldTime >= 0 && worldTime <  1000) 
			{
				float time = smoothstep(0, 1000, float(worldTime));
				samples = texture(depthtex0, altCoord).r == 1.0 ?  mix(earlyGodrayColor, godrayColor, time) : vec3(0.0);
			
			}
			else if (worldTime >= 12350 && worldTime <  23500) 
			{
				float time = smoothstep(12350, 13000, float(worldTime));
				samples = texture(depthtex0, altCoord).r == 1.0 ? vec3(1.0, 1.0, 1.0) * mix(earlyGodrayColor, moonrayColor, time) : vec3(0.0);
				weight = 0.08 * MOON_ILLUMINANCE;
				decay = 1.0;
				exposure = 0.81;
			}
			else if (worldTime >= 11000 && worldTime <  12350) 
			{
				float time = smoothstep(11000, 12350, float(worldTime));
				samples = texture(depthtex0, altCoord).r == 1.0 ?  mix(godrayColor, earlyGodrayColor, time) : vec3(0.0);
			}
            //calculation for the godrays while the camera is in the water
			if(isEyeInWater == 1)
			{
				 samples = texture(depthtex1, altCoord).r == 1.0 ? mix(vec3(0.1882, 0.902, 0.6745), godrayColor, waterTint) : vec3(0.0);
				 weight = 0.3;
				 decay = 1.0;
				 exposure = 0.71;
			}
			//total samples multiplied by the illumination weight
            samples *= illuminationDecay * weight;
			//set the color to use the samples
            color += samples;
            //set the illumination decay to the set decay 
			illuminationDecay *= decay;
			//i forgot what this was for
            altCoord -= deltaTexCoord;
	}	
	//sample the godrays through the color buffer and apply exposure
    color /= GODRAYS_SAMPLES;
	color *= exposure;
	
    return color;
	
#endif
}