class_name tower_block extends Node2D

@export var block_type: int = 0
@export var block_cost: int = 0

@onready var image_type: Sprite2D = $image
@onready var block_pos: Node2D = $Position
@onready var cost: Label = $Label

var click = 0

func _ready():
	set_block_type(block_type, block_cost)

func set_block_type(_type: int, _cost: int):
	image_type.set_image(_type)
	cost.set_text(str(_cost))

func _process(delta):
	if click == 1:
		block_pos.position = get_global_mouse_position() - Vector2(550,250)
	elif click == 0:
		block_pos.position = block_pos.position
		
	print(click)
