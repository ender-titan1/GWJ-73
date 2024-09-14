extends Sprite2D

var card_image: int = 1

var sentury = preload("res://imports/sentury 2.0.png")
var icon = preload("res://icon.svg")

func _ready():
	set_image(card_image)

func set_image(_image: int):
	card_image = _image
	
	texture = sentury
	if _image == 1:
		texture = sentury
	elif _image == 2:
		texture = icon
