extends Node2D

const SPAWN_OFFSET: int = -10

@export var grid: TileMap
@export var block_scene: PackedScene
@onready var timer: Timer = $BlockFallTimer
@onready var preview_block: Block = $PreviewBlock

var block_definitions: Array = []
var layers: Dictionary = {}

var tower_height = 0
var falling_block: Block
var falling_block_center_cell_pos: Vector2
var marked_for_placement: bool = false
var rng: RandomNumberGenerator

func _ready():
	rng = RandomNumberGenerator.new()
	layers[int(8)] = []
	init_blocks()
	debug_spawn()

func debug_spawn():
	if falling_block != null:
		return

	var block: Block = block_scene.instantiate()
	block.set_definition(block_definitions[rng.randi_range(0, 1)])
	add_child(block)

	spawn(block)

func init_blocks():
	var blocks_json = FileAccess.get_file_as_string("res://resources/blocks.json")
	var json = JSON.parse_string(blocks_json)

	for key in json:
		block_definitions.append(BlockDefinition.new(key, json[key]))

func _input(event):

	if event.is_action_pressed("shift_left"):
		shift_falling(-1, 0)
	
	if event.is_action_pressed("shift_right"):
		shift_falling(1, 0)

	if event.is_action_pressed("rotate"):
		rotate_falling()
	
	if event.is_action_pressed("debug"):
		debug_spawn()

	if event.is_action_pressed("shift_down"):
		timer.wait_time = 0.15
	
	if event.is_action_released("shift_down"):
		timer.wait_time = 0.6

func on_timer_timeout():
	if !marked_for_placement:
		shift_falling(0, 1)

	check_for_placement()

func check_for_placement():
	var shouldPlace = false
	for offset in falling_block.offsets:
		var cell_to_check = offset + Vector2(0, 1) + falling_block_center_cell_pos

		if cell_is_occupied(cell_to_check):
			shouldPlace = true
			break

	if shouldPlace && !marked_for_placement:
		marked_for_placement = true
		return

	if !shouldPlace:
		marked_for_placement = false
		return

	if shouldPlace && marked_for_placement:
		place_block()

func place_block():
	var block = falling_block

	for offset in block.offsets:
		var pos = offset + falling_block_center_cell_pos

		if !layers.has(int(pos.y)):
			print("creating layer")
			print(pos.y)
			layers[int(pos.y)] = []

		layers[int(pos.y)].append(int(pos.x))

	print(layers)

	block.opacity = 1
	preview_block.visible = false

	timer.stop()
	falling_block = null
	marked_for_placement = false

func spawn(block: Node2D):
	if falling_block != null:
		print("Attempted to spawn block while block is already falling")
		return

	var spawn_height = tower_height + SPAWN_OFFSET
	var cell_pos = Vector2i(0, spawn_height)
	var local_spawn_height = grid.map_to_local(cell_pos)
	block.position = local_spawn_height
	block.opacity = 0.5
	falling_block = block
	falling_block_center_cell_pos = cell_pos
	timer.start()

	preview_block.visible = true
	preview_block.offsets = falling_block.definition.offsets
	preview_block.rotation_degrees = 0
	redraw_preview()

func shift_falling(x, y):
	if falling_block == null:
		return

	if x != 0:
		for offset in falling_block.offsets:
			var pos = offset + falling_block_center_cell_pos + Vector2(x, 0)

			if cell_is_occupied(pos):
				return

	if y != 0:
		for offset in falling_block.offsets:
			var pos = offset + falling_block_center_cell_pos + Vector2(0, y)

			if cell_is_occupied(pos):
				return

	falling_block_center_cell_pos += Vector2(x, y)
	falling_block.position = grid.map_to_local(falling_block_center_cell_pos)
	redraw_preview()

func rotate_falling():
	if falling_block == null:
		return

	if falling_block.definition.inhibit_rotation:
		return

	var offsets = falling_block.get_rotated_offsets()
	for offset in offsets:
		var cell = offset + falling_block_center_cell_pos

		if cell_is_occupied(cell):
			return

	falling_block.offsets = offsets
	falling_block.rotation_degrees += 90

	preview_block.offsets = offsets
	preview_block.rotation_degrees += 90

func cell_is_occupied(cell: Vector2) -> bool:
	var x = cell.x
	var y = cell.y

	if y > 8:
		return true

	if x > 5 || x < -6:
		return true

	if !layers.has(int(y)):
		return false

	if layers[int(y)].has(int(x)):
		return true

	return false

func redraw_preview():
	preview_block.set_definition(falling_block.definition)
	preview_block.visible = true
	preview_block.opacity = 0.35

	var pos = get_prediction_center_pos()

	preview_block.position = grid.map_to_local(pos)

	if pos.y <= falling_block_center_cell_pos.y:
		preview_block.visible = false

func get_prediction_center_pos() -> Vector2:
	var block_pos = Vector2(falling_block_center_cell_pos.x, 8)
	var valid = false

	# This algorithm is horrible and inefficient but better than the overcomplicated bullshit I tried to write

	while !valid:
		for offset in falling_block.offsets:
			var pos = offset + block_pos
			
			if cell_is_occupied(pos):
				valid = false
				break

			var clear_view = true
			for y in layers:
				var layer = layers[y]

				if y >= pos.y:
					continue

				if layer.has(int(pos.x)):
					clear_view = false
					break

			if !clear_view:
				valid = false
				break

			valid = true

		if !valid:
			block_pos.y -= 1

	return block_pos
