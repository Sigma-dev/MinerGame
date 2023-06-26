@tool
extends Node2D

@export var start_spawned = false
@export var zone : PackedScene = null
var coords = Vector2i(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	coords = Vector2i(int(global_position.x) / 512, int(global_position.y) / 276)
	get_parent().add_zone_spawner(self, coords)
	if start_spawned || Engine.is_editor_hint():
		get_parent().deploy_zone_at(coords)
	pass # Replace with function body.


func deploy():
	var instance = zone.instantiate()
	add_child(instance);
	instance.global_position = global_position
	#get_parent().add_zone(instance)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
