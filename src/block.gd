class_name Block extends Node2D

var sprite: Sprite2D
var definition: BlockDefinition
var offsets: Array
var opacity: float:
	set(value):
		modulate = Color(1, 1, 1, value)

func set_definition(def: BlockDefinition):
	if definition != null && definition.name == def.name:
		return

	definition = def
	sprite = $Sprite2D
	sprite.texture = definition.texture

	var pxSize = def.size * 32
	var shift00 = Vector2(pxSize.x / 2 - 16, pxSize.y / 2 - 16)
	var shift = shift00 - def.center * 32
	sprite.position = shift

	offsets = def.offsets

func get_rotated_offsets() -> Array:
	var rotated_offsets = []
	for offset in offsets:
		var x = offset.x
		var y = offset.y
		var new_offset = Vector2(-y, x)
		rotated_offsets.append(new_offset)

	return rotated_offsets
