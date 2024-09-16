class_name Block extends Node2D

var sprite: Sprite2D
var definition: BlockDefinition

func set_definition(def: BlockDefinition):
	definition = def
	sprite = $Sprite2D
	sprite.texture = definition.texture

	var pxSize = def.size * 32
	var shift00 = Vector2(pxSize.x / 2 - 16, pxSize.y / 2 - 16)
	var shift = shift00 + def.center
	sprite.position += shift


