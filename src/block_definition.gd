class_name BlockDefinition extends Resource

var offsets: Array
var center: Vector2
var texture: Texture2D
var size: Vector2i
var inhibit_rotation: bool
var name: String

func _init(key: String, json_dict: Dictionary={}):
	var string_array = json_dict["matrix"]

	name = key
	offsets = []
	size = Vector2i(string_array[0].length(), string_array.size())
	center = Vector2(json_dict["center"][0], json_dict["center"][1])

	if json_dict.has("rotate"):
		inhibit_rotation = !json_dict["rotate"]
	else:
		inhibit_rotation = false

	if json_dict["sprite"] != null:
		texture = load("res://imports/" + json_dict["sprite"])

	var y = 0
	for string in string_array:
		var x = 0
		for character in string:
			if character != ' ':
				offsets.append(Vector2(x, y) - center)
		
			x += 1
		y += 1  