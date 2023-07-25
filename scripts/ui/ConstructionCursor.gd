class_name ConstructionCursor

extends Node2D

static var instance = null
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var construction_detector: Area2D = $ConstructionDetector
static var slot_data : SlotData = SlotData.new()
@onready var range_sprite = $RangeSprite
static var construction_cursor_scene = preload("res://scenes/prefabs/Cursor.tscn")
static var inv = preload("res://resources/default/player_inventory.tres")
static var cross_sprite = preload("res://assets/cross.png")
var hovered_construction = null
signal _update()

static func set_data(new_slot_data: SlotData, parent: Node):
	if !is_instance_valid(instance):
		instance = construction_cursor_scene.instantiate()
		parent.call_deferred("add_child", instance)
	slot_data = new_slot_data

func _ready():
	update()
	construction_detector.area_entered.connect(_on_entered_construction)
	construction_detector.area_exited.connect(_on_exited_construction)

func _on_entered_construction(area: Area2D):
	hovered_construction = area.get_parent()
	hovered_construction.modulate = Color(1,0.2, 0.2) 
	sprite_2d.texture = cross_sprite
	sprite_2d.offset.y = -8

func _on_exited_construction(area: Area2D):
	hovered_construction.modulate = Color(1, 1, 1)
	hovered_construction = null
	sprite_2d.texture = null

func update():
	sprite_2d.texture = null
	range_sprite.visible = false


func _physics_process(delta):
	if is_instance_valid(hovered_construction):
		hovered_construction.modulate = Color(1,0.2, 0.2) 
		if (Input.is_action_just_pressed("alt_click")):
			hovered_construction.queue_free()
			inv.add_item(hovered_construction.get_item_data())

func _process(delta):
	visible = UIStatus.enabled
	global_position = get_global_mouse_position()
	sprite_2d.global_position = global_position
	if slot_data.is_empty():
		return
	if (Input.is_action_just_pressed("alt_click")):
		inv.add_item(slot_data.item_data, slot_data.quantity)
		slot_data.quantity = 0
		update()
		return
	if hovered_construction:
		return
	var player_pos = get_player_pos()
	range_sprite.visible = true
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
	#sprite_2d.position = Vector2.ZERO
	
func cursor_valid(pos):
	if (Input.is_action_just_pressed("click")):
		var construction =  ConstructionData.construction.instantiate()
		construction.construction_item = slot_data.item_data
		construction.global_position = pos
		get_parent().add_child(construction)
		#if slot_data.quantity > 1:
		#	inv.add_item(slot_data.item_data, slot_data.quantity - 1)
		#inv.remove_item_quantity(slot_data.item_data, slot_data.quantity)
		slot_data.quantity -= 1
	sprite_2d.modulate = Color(0.5, 0.5, 0.5, 0.8)
	sprite_2d.global_position = pos

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
