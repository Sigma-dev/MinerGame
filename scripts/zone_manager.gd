@tool
extends Sprite2D

var wall_scene = preload("res://prefabs/wall.tscn")
var prompting = []
var current = null
var colors = [Color(1.0, 0.0, 0.0, 1.0),
		  Color(0.0, 1.0, 0.0, 1.0),
		  Color(0.0, 0.0, 1.0, 1.0),
		Color(1.0, 1.0, 1.0, 1.0)
		]
var color = null
	
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	color = colors[randi() % colors.size()]
	if Engine.is_editor_hint():
		return
	var length = 0.6
	var width = 256
	var height = 144
	spawn_wall(Vector2(0, -height), Vector2(length, 11), 0)
	spawn_wall(Vector2(width, 0), Vector2(length, 6), 90)
	spawn_wall(Vector2(0, height), Vector2(length, 11), 180)
	spawn_wall(Vector2(-width, 0), Vector2(length, 6), -90)

	pass # Replace with function body.

func _draw():
	var width = 512
	var height = 288
	#if Engine.is_editor_hint():
	#	draw_rect(Rect2(Vector2(-width / 2, -height / 2), Vector2(width, height)), color)

func spawn_wall(pos, scl, rot = 0):
	var instance = wall_scene.instantiate()
	add_child(instance);
	instance.global_position = pos
	#instance.scale = scl

	instance.init(rot, scl, self)

func try_prompt(wall):
	prompting.append(wall)
	
func remove_wall(wall):
	wall.queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Engine.is_editor_hint():
		return
	if prompting.size() == 0:
		current = null
	if prompting.size() > 0 && !prompting.has(current):
		current = prompting[0]
	if current != null:
		current.prompt()
		if (Input.is_action_just_pressed("interact")):
			remove_wall(current)
	pass
	prompting.clear()
