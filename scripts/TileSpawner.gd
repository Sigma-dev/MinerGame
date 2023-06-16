extends Node2D

var rng = RandomNumberGenerator.new()
@export var to_spawn: PackedScene
@export var spawn_protection: PackedScene
@onready var tilemap: TileMap = get_parent()
@onready var shapecast: ShapeCast2D = $ShapeCast2D

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

func spawn_on_random_ground():
	var candidates = get_ground_tiles()
	var iter = 0
	while iter < 30:
		iter += 1
		var tile = candidates[randi() % candidates.size()]
		var ontop_pos = Vector2i(tile.x, tile.y - 1)
		if (tilemap.get_cell_tile_data(0, ontop_pos) != null):
			continue
		shapecast.global_position = to_global(tilemap.map_to_local(ontop_pos))
		shapecast.force_shapecast_update()
		print(shapecast.get_collision_count())
		if (shapecast.get_collision_count() > 0):
			continue
		var spawn_pos = to_global((tilemap.map_to_local(tile) + tilemap.map_to_local(ontop_pos)) / 2)
		spawn_at_pos(spawn_pos, to_spawn)
		break
	#get the position of the top side of the selected tile by dividing the position of the tile on top of it with  map_to_local
	#spawn object on the top side coordinates

func spawn_at_pos(pos, object = to_spawn, ):
	var instance = object.instantiate()
	instance.global_position = pos
	get_tree().root.get_child(0).add_child(instance);
	if instance.has_method("set_manager"):
		instance.set_manager(self)

func _ready():
	get_ground_tiles()# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if to_spawn && Input.is_action_pressed("click"):
		print("jump")
		spawn_on_random_ground()
	pass
