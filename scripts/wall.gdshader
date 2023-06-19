shader_type canvas_item;

void fragment() {
	float rng = texture(TEXTURE, vec2(0, UV.y)).r / 2.0;
	float start = 1.0 - UV.x;
	float time = TIME * 0.2;
	float add = sin((UV.y + time) * 20.0) / 5.0;
	float alpha =  (start * 1.5 + add) / 2.0;
	COLOR = vec4(1, 0, 0, alpha * 0.7);
}
