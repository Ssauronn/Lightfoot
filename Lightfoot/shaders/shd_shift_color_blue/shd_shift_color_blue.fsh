//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float freeze_bar_percentage;

void main() {
	vec2 tex = v_vTexcoord;
	vec4 color = texture2D(gm_BaseTexture, tex);
	color.r = freeze_bar_percentage;
	color.g = freeze_bar_percentage;
	
    gl_FragColor = color;
}


