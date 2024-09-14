extends Node2D

const base_spawn_height: int = -10;

@export var grid: TileMap;
@export var block_to_spawn: Sprite2D;

@onready var timer: Timer = $BlockFallTimier;

var tower_height = 0;
var falling_block: Node2D;
var falling_block_center_cell_pos: Vector2i;

func _ready():
	spawn(block_to_spawn);

func _input(event):
	if event.is_action_pressed("shift_left"):
		print("left");
		shift_falling(-1, 0);
	
	if event.is_action_pressed("shift_right"):
		shift_falling(1, 0);
	

func on_timer_timeout():
	shift_falling(0, 1);
	# Check if the block should be placed

func spawn(block: Node2D):

	if falling_block != null:
		print("Attempted to spawn block while block is already falling");
		return;

	var spawn_height = tower_height + base_spawn_height;
	var cell_pos = Vector2i(0, spawn_height);
	var local_spawn_height = grid.map_to_local(cell_pos);
	block.position = local_spawn_height;
	falling_block = block;
	falling_block_center_cell_pos = cell_pos;
	timer.start();

func shift_falling(x, y):
	falling_block_center_cell_pos += Vector2i(x, y);
	falling_block.position = grid.map_to_local(falling_block_center_cell_pos)
