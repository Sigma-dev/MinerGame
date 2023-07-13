class_name ConstructionCursor

extends Node2D

static var instance = null
@onready var sprite_2d = $Sprite2D
@onready var ray_cast_2d = $RayCast2D
static var slot_data : SlotData = SlotData.new()
@onready var range_sprite = $RangeSprite
static var construction_cursor_scene = preload("res://scenes/prefabs/ConstructionCursor.tscn")
static var inv = preload("res://resources/default/player_inventory.tres")

static func set_data(new_slot_data: SlotData, new_inv: InventoryData, parent: Node):
	#inv = new_inv
	if !instance:
		instance = construction_cursor_scene.instantiate()
		parent.add_child(instance) 
	slot_data = new_slot_data

func _process(delta):
	if slot_data.is_empty():
		visible = false
		return
	visible = true
	if (Input.is_action_just_pressed("alt_click")):
		inv.add_item(slot_data.item_data, slot_data.quantity)
		slot_data.quantity = 0
	var player_pos = get_player_pos()
	global_position = get_global_mouse_position()
	range_sprite.global_position = player_pos
	var pos = null
	if slot_data.item_data.construction:
		pos = get_construction_pos() 
	if !pos || pos.distance_to(player_pos) > 128:
		cursor_invalid()
	else:
		cursor_valid(pos)

func cursor_invalid():
	if slot_data.item_data.construction:
		sprite_2d.texture = slot_data.item_data.construction.preview_texture
		sprite_2d.offset.y = slot_data.item_data.construction.height * -16
	else:
		sprite_2d.texture = slot_data.item_data.texture
	sprite_2d.modulate = Color(0.5, 0.1, 0.1, 0.5)
	sprite_2d.position = Vector2.ZERO
	
func cursor_valid(pos):
	sprite_2d.modulate = Color(0.5, 0.5, 0.5, 0.8)
	sprite_2d.global_position = pos
	if (Input.is_action_just_pressed("click")):
		var construction =  slot_data.item_data.construction.construction.instantiate()
		construction.global_position = pos
		get_parent().add_child(construction)
		if slot_data.quantity > 1:
			inv.add_item(slot_data.item_data, slot_data.quantity - 1)
		#inv.remove_item_quantity(slot_data.item_data, slot_data.quantity)
		slot_data.quantity -= 1

func get_player_pos():
	return get_tree().get_nodes_in_group("Player")[0].global_position

static func get_slot_data() -> SlotData:
	return slot_data

func get_construction_pos():
	var col = ray_cast_2d.get_collider()
	var point = ray_cast_2d.get_collision_point()
	if col is TileMap:
		var tile_spawner : TileSpawner = col.get_child(0)
		var tile = col.local_to_map(point)
		if !(tile_spawner.is_tile_available(tile)):
			return null
		var tile_pos = col.map_to_local(tile)
		var offset = (slot_data.item_data.construction.preview_texture.get_height() / 16 - 1)
		var top_tile_pos = col.map_to_local(Vector2(tile.x, tile.y - offset))
		var pos = (tile_pos + top_tile_pos) / 2
		return pos
