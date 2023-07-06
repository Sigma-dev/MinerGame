extends Node2D

class_name ConstructionManager

@onready var construction_check = $ConstructionCheck
@onready var construction_preview = $ConstructionPreview
var construction_data : ConstructionData = null
var preview_location = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start_preview(new_construction_data : ConstructionData):
	construction_data = new_construction_data
	
func stop_preview():
	construction_data = null
	construction_preview.visible = false


func _update():
	update_preview_location()
	if preview_location:
		print("set")
		construction_preview.global_position = preview_location
	construction_preview.texture = construction_data.preview_texture

func update_preview_location():
	var col = construction_check.get_collider()
	var point = construction_check.get_collision_point()
	construction_preview.visible = false
	if col is TileMap:
		var tile_spawner : TileSpawner = col.get_child(0)
		var tile = col.local_to_map(point)
		if !(tile_spawner.is_tile_available(tile)):
			return
		var tile_pos = col.map_to_local(tile)
		var offset = (construction_data.preview_texture.get_height() / 16 - 1)
		var top_tile_pos = col.map_to_local(Vector2(tile.x, tile.y - offset))
		var pos = (tile_pos + top_tile_pos) / 2
		preview_location =  pos
		construction_preview.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (construction_data):
		_update()
