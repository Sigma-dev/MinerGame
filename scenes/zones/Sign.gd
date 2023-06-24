extends Sprite2D

@onready var area : Area2D = $Area2D
@export var zone_coords : Vector2i
@export var gold_price = 5
@onready var label : Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = str(gold_price)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if (area.get_overlapping_bodies().size() > 0 && Input.is_action_just_pressed("interact")):
		get_parent().get_parent().get_parent().deploy_zone_at(zone_coords)
	pass
