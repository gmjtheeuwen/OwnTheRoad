shader_type spatial;
render_mode unshaded, fog_disabled;

uniform sampler2D screenTexure : hint_screen_texture;
uniform float pixelSize : hint_range(0.0, 100.0, 2) = 8.0;

uniform sampler2D distortionTexture;

void vertex() {
	POSITION = vec4(VERTEX.xy, 1.0 ,1.0);
}

void fragment() {
	vec2 texSize = vec2(textureSize(screenTexure, 0));
	vec2 pixelCount = texSize;
	vec2 pixelateUV = floor(SCREEN_UV * pixelCount) / pixelCount;
	vec4 color = texture(screenTexure, pixelateUV);

	//vec2 distortedUV = SCREEN_UV + texture(distortionTexture, UV + 0.5).r * 0.01;
	//vec4 screenColor = texture(screenTexure, distortedUV);

	//vec4 grayscaling = vec4(0.2 ,0.2 ,0.2 ,0.2);

	float noice = texture(distortionTexture, UV + TIME * 0.02).r * 0.9;

	ALBEDO = texture(screenTexure, SCREEN_UV + noice).rgb + color.rgb;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
