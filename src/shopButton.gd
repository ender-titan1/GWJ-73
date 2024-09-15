extends MenuButton

var type_1 = preload("res://imports/sentury 2.0.png")
var type_2 = preload("res://icon.svg")
var type_3 = preload("res://imports/L-Right.png")

var shop_menu: PopupMenu = self.get_popup()
var type = 0
var rng = RandomNumberGenerator.new()


func _ready():
	for i in range(0,3):
		type = rng.randi_range(1,3)
		if type == 1:
			shop_menu.add_icon_item(type_1,"sentury")
		elif type == 2:
			shop_menu.add_icon_item(type_2,"icon")
		elif type == 3:
			shop_menu.add_icon_item(type_3,"block")

