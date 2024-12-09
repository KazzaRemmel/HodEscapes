shader_type canvas_item;

uniform float speed;
//
//void vertex() {
	//// Called for every vertex the material is visible on.
//}

void fragment() {
    vec4 texColor = texture(TEXTURE, vec2(UV.x, UV.y - TIME * speed));
	COLOR = texColor;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
