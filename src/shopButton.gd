extends MenuButton

@export var Money: int = 0
@onready var money_lablel: Label = $"../money"

var type_1 = preload("res://imports/sentury 2.0.png")
var type_2 = preload("res://icon.svg")
var type_3 = preload("res://imports/L-Right.png")

var shop_menu: PopupMenu = self.get_popup()

var type = 0
var rng = RandomNumberGenerator.new()


func money_display(_money: int):
	money_lablel.set_text(str(_money))

func _ready():
	money_display(Money)
	for i in range(0,3):
		type = rng.randi_range(1,3)
		if type == 1:
			shop_menu.add_icon_item(type_1,"30")
		elif type == 2:
			shop_menu.add_icon_item(type_2,"50")
		elif type == 3:
			shop_menu.add_icon_item(type_3,"10")
			
	shop_menu.connect("index_pressed", 
	Callable(self, "_clicked_shop_item"))

func _clicked_shop_item(index: int):
	match index:
		0:
			print(shop_menu.get_item_text(index))
			var _c = int(shop_menu.get_item_text(index))
			if Money >= _c:
				Money -= _c
				money_display(Money)
				shop_menu.remove_item(index)
		1:
			print(shop_menu.get_item_text(index))
			var _c = int(shop_menu.get_item_text(index))
			if Money >= _c:
				Money -= _c
				money_display(Money)
				shop_menu.remove_item(index)
		2:
			print(shop_menu.get_item_text(index))
			var _c = int(shop_menu.get_item_text(index))
			if Money >= _c:
				Money -= _c
				money_display(Money)
				shop_menu.remove_item(index)
			
