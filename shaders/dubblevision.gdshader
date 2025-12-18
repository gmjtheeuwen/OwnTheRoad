shader_type spatial;
render_mode unshaded, fog_disabled;

uniform float wobbleSpeed : hint_range(0.0, 0.5, 0.01) = 0.05;
uniform float dubblevisionAndWobbleStrengt : hint_range(0.0, 0.5, 0.01) = 0.02;

uniform sampler2D screenTexure : hint_screen_texture;

uniform sampler2D distortionTexture;

void vertex() {
	POSITION = vec4(VERTEX.xy, 0.5 ,1);
}

void fragment() {
	vec2 texSize = vec2(textureSize(screenTexure, 0));
	vec2 pixelCount = texSize;
	vec2 pixelateUV = floor(SCREEN_UV * pixelCount) / pixelCount;
	vec4 color = texture(screenTexure, pixelateUV);

	//vec2 distortedUV = SCREEN_UV + texture(distortionTexture, UV + 0.5).r * 0.01;
	//vec4 screenColor = texture(screenTexure, distortedUV);

	vec4 grayscaling = vec4(0.05 ,0.05 ,0.05 ,0.05);

	float noise = texture(distortionTexture, UV + TIME * wobbleSpeed).r * dubblevisionAndWobbleStrengt;

	ALBEDO = texture(screenTexure, SCREEN_UV + noise).rgb + color.rgb;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
