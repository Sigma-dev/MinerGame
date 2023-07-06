class_name ConstructionCursor

extends Node2D

@onready var sprite_2d = $Sprite2D
@onready var ray_cast_2d = $RayCast2D
var item_data : ItemData = null
@onready var range_sprite = $RangeSprite
var inv : InventoryData = null

func set_data(new_item_data: ItemData, new_inv: InventoryData):
	inv = new_inv
	item_data = new_item_data

func _process(delta):
	if item_data == null:
		return
	if (Input.is_action_just_pressed("alt_click")):
		queue_free()
	var player_pos = get_player_pos()
	global_position = get_global_mouse_position()
	range_sprite.global_position = player_pos
	var pos = get_construction_pos()
	if !pos || pos.distance_to(player_pos) > 128:
		cursor_invalid()
	else:
		cursor_valid(pos)

func cursor_invalid():
	sprite_2d.texture = item_data.construction.preview_texture
	sprite_2d.modulate = Color(0.5, 0.1, 0.1, 0.5)
	sprite_2d.offset.y = item_data.construction.height * -16
	sprite_2d.position = Vector2.ZERO
	
func cursor_valid(pos):
	sprite_2d.modulate = Color(0.5, 0.5, 0.5, 0.8)
	sprite_2d.global_position = pos
	if (Input.is_action_just_pressed("click")):
		var construction =  item_data.construction.construction.instantiate()
		construction.global_position = pos
		get_parent().add_child(construction)
		inv.remove_item_quantity(item_data, 1)
		queue_free()

func get_player_pos():
	return get_tree().get_nodes_in_group("Player")[0].global_position

func get_construction_pos():
	var col = ray_cast_2d.get_collider()
	var point = ray_cast_2d.get_collision_point()
	if col is TileMap:
		var tile_spawner : TileSpawner = col.get_child(0)
		var tile = col.local_to_map(point)
		if !(tile_spawner.is_tile_available(tile)):
			return null
		var tile_pos = col.map_to_local(tile)
		var offset = (item_data.construction.preview_texture.get_height() / 16 - 1)
		var top_tile_pos = col.map_to_local(Vector2(tile.x, tile.y - offset))
		var pos = (tile_pos + top_tile_pos) / 2
		return pos
