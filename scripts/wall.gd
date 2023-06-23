extends Node2D

@onready var label : Label = $Label
@onready var wall : Node2D = $ScaledRotated
@onready var area : Area2D = $ScaledRotated/Area2D
var master = null
var prompting = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(rot, scale, new_master):
	master = new_master
	wall.global_rotation_degrees += rot
	wall.scale = scale
	label.global_position += wall.global_transform.x.normalized() * 30

func prompt():
	prompting = true

func _physics_process(delta):
	#
	var bodies = area.get_overlapping_bodies()
	if bodies.size() >  0:
		master.try_prompt(self)
	else:
		prompting = false
	pass

func _process(delta):
	label.visible = prompting
	pass
