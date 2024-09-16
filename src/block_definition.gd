class_name BlockDefinition extends Resource

var offsets: Array
var center: Vector2
var texture: Texture2D
var size: Vector2i

func _init(json_dict: Dictionary={}):
	offsets = []
	size = Vector2i(json_dict["matrix"].size(), json_dict["matrix"][0].length())
	center = Vector2(json_dict["center"][0], json_dict["center"][1])

	if json_dict["sprite"] != null:
		texture = load("res://imports/" + json_dict["sprite"])

	var string_array = json_dict["matrix"]

	var y = 0
	for string in string_array:
		var x = 0
		for character in string:
			if character != ' ':
				offsets.append(Vector2i(x, y))
		
			x += 1
		y += 1  