@tool
extends Node2D

@export var start_spawned = false
@export var zone : PackedScene = null
var coords = Vector2i(0, 0)

func _ready():
	coords = Vector2i(int(global_position.x) / 512, int(global_position.y) / 276)
	get_parent().add_zone_spawner(self, coords)
	if start_spawned || Engine.is_editor_hint():
		get_parent().deploy_zone_at(coords)


func deploy():
	var instance = zone.instantiate()
	add_child(instance);
	instance.global_position = global_position

