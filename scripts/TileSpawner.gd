extends Node2D

var rng = RandomNumberGenerator.new()
@export var to_spawn: PackedScene
@onready var tilemap: TileMap = get_parent()
@onready var shapecast: ShapeCast2D = $ShapeCast2D
var next_spawn_time = -1
var elapsed = 0
var spawn_time_min = 5.0
var spawn_time_random_range = 3.0

func get_ground_tiles():
	var coords = [
		Vector2i(1, 2),
		Vector2i(2, 1),
		Vector2i(3, 1),
		Vector2i(4, 1),
		Vector2i(5, 1),
		Vector2i(8, 1),
		Vector2i(6, 2),
		Vector2i(8, 3),
		Vector2i(9, 3),
		Vector2i(10, 3)
	]
	var tiles = []
	for coord in coords:
		tiles += tilemap.get_used_cells_by_id(0, 0, coord)
	return tiles

func get_random_available_ground_tile():
	var candidates = get_ground_tiles()
	randomize()
	candidates.shuffle()
	for tile in candidates:
		var ontop_pos = Vector2i(tile.x, tile.y - 1)
		if (tilemap.get_cell_tile_data(0, ontop_pos) != null):
			continue
		shapecast.global_position = to_global(tilemap.map_to_local(ontop_pos))
		shapecast.force_shapecast_update()
		if (shapecast.get_collision_count() > 0):
			continue
		return tile
	return null

func spawn_on_random_ground():
	var tile = get_random_available_ground_tile()
	if (tile == null):
		return
	var top_tile = Vector2i(tile.x, tile.y - 1)
	var spawn_pos = to_global((tilemap.map_to_local(tile) + tilemap.map_to_local(top_tile)) / 2)
	spawn_at_pos(spawn_pos, to_spawn)

func spawn_at_pos(pos, object = to_spawn, ):
	var instance = object.instantiate()
	instance.global_position = pos
	add_child(instance);

func handle_spawning(delta):
	if elapsed > next_spawn_time:
		print("pop")
		spawn_on_random_ground()		
		next_spawn_time = elapsed + rng.randf_range(spawn_time_min, spawn_time_min + spawn_time_random_range)
	print("elapsed: " + str(elapsed))
	print("next:" + str(next_spawn_time))
	elapsed += delta

func _physics_process(delta):
	handle_spawning(delta)
	#if to_spawn && Input.is_action_pressed("click"):

	pass
