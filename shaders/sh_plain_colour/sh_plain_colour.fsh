varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 colour;
uniform float value;

void main() {
	vec4 baseCol = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	gl_FragColor = vec4(mix(baseCol.rgb, colour, value), baseCol.a);
}