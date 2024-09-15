extends MenuButton

var Shop_menu: PopupMenu = self.get_popup()
var Icon_1 = preload("res://icon.svg")
var Icon_2 = preload("res://imports/sentury 2.0.png")

var rng = RandomNumberGenerator.new()

@export var type: int = 0

func _ready():
	type = rng.randi_range(1,2)
	if type == 1:
		Shop_menu.add_icon_item(Icon_1,"hello")
	elif type == 2:
		Shop_menu.add_icon_item(Icon_2,"test")
