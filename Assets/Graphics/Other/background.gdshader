shader_type canvas_item;

void fragment()
{
	vec2 uv = UV;
	uv.x = fract(uv.x);
	COLOR.rgb = texture(TEXTURE, uv).rgb;
}