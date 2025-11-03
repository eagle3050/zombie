shader_type canvas_item;
uniform vec4 silhouette_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
void fragment() {
  vec4 origin = texture(TEXTURE, UV);
  // Set the color to the silhouette color, keeping original alpha
  COLOR = vec4(silhouette_color.rgb, origin.a);
}
