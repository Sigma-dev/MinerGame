extends Node2D

var wall = preload("res://prefabs/wall.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_wall(Vector2(-256, 0), Vector2(0.2, 6))
	spawn_wall(Vector2(256, 0), Vector2(0.2, 6), 180)
	spawn_wall(Vector2(0, -150), Vector2(0.2, 11), 90)
	spawn_wall(Vector2(0, 150), Vector2(0.2, 11), -90)
	pass # Replace with function body.


func spawn_wall(pos, scl, rot = 0):
	var instance = wall.instantiate()
	add_child(instance);
	instance.global_position = pos
	instance.scale = scl
	instance.rotation_degrees = rot

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
