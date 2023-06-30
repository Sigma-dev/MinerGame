extends Node2D

@onready var area : Area2D = $Area2D
@export var zone_coords : Vector2i
@export var gold_price = 5
@onready var label : Label = $Sign/Label
@onready var anim : AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = str(gold_price)
	pass # Replace with function body.

func on_enter(not_used):
	anim.play("up")
	
func on_exit(not_used):
	anim.play("down")

func get_player_gold():
	return 5
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if (area.get_overlapping_bodies().size() > 0 && Input.is_action_just_pressed("interact")):
		if (get_player_gold() < gold_price):
			anim.play("deny")
		else:
			get_parent().get_parent().get_parent().deploy_zone_at(zone_coords)
			queue_free()
	pass
