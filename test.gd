extends Node2D

@onready var blockScene: PackedScene = preload("res://scenes/tower block.tscn")

@onready var Spawn_point = $Spawn_point

var type = 0

func _on_button_pressed():
	var block = blockScene.instantiate()
	Spawn_point.add_child(block)
	block.set_block_type(type)


func _on_button_2_pressed():
	type = 1


func _on_button_3_pressed():
	type = 2
