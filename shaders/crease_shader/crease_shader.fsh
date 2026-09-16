//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D u_texture;
uniform vec2 eraser_position;
uniform float eraser_radius;

void main()
{
	vec2 pixel_position = vec2(gl_FragCoord.x,gl_FragCoord.y); // Use gl_FragCoord to get the pixel's screen position
    float distance_to_eraser = distance(pixel_position, eraser_position);
	
	float alpha = step(eraser_radius, distance_to_eraser);

	vec4 color = texture2D(u_texture, v_vTexcoord);
	gl_FragColor = vec4(color.rgb, color.a * alpha);
}
