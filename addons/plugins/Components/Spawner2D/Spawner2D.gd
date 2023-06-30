@tool
extends Node2D
class_name Spawner2D
@export var to_spawn: PackedScene
@export var spawn_as_child: bool
@export var amount = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func spawn():
	var instance = to_spawn.instantiate()
	get_parent().get_parent().add_child(instance);
	instance.global_position = global_position
	return instance

func spawn_at(pos):
	var instance = spawn()
	instance.global_position = pos

func trigger(a = 0, b = 0, c = 0, d = 0, e = 0, f = 0):
	for i in amount:
		spawn()

func trigger_at(pos):
	for i in amount:
		spawn_at(pos)
