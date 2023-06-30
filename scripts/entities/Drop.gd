extends RigidBody2D
@onready var anim : AnimationPlayer = $AnimationPlayer 
@onready var area : Area2D = $Area2D
@onready var shape: CollisionShape2D = $CollisionShape2D
var item: ItemData = null
var target : Node2D = null
var chase_time = 1

func _ready():
	anim.play("default")
	pass
	
func set_resource(resource):
	item = resource

func chase(delta):
	var dir = (target.global_position - global_position).normalized()
	var speed = chase_time * 5
	gravity_scale = 0
	shape.disabled = true
	linear_velocity = (linear_velocity.length() + speed) * dir
	chase_time += delta

func check_collected():
	var dist = global_position.distance_to(target.global_position)
	if dist < 40:
		scale = Vector2(dist / 40.0, dist / 40.0)
	if dist < 10:
		target.pickup_item(item)
		queue_free()

func _physics_process(delta):
	for body in area.get_overlapping_bodies():
		if body.has_method("is_player"):
			target = body
	if target:
		chase(delta)
		check_collected()

