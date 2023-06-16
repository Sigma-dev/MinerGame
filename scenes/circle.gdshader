shader_type canvas_item;

void fragment() {
	float variance = sin(TIME * 3.0) / 6.0;
	float transparency = distance(UV, vec2(0.5, 0.5)) * 7.0 + variance;
	float alpha = 1.0 - transparency;
	COLOR = vec4(1, 1, 1, alpha);
}
