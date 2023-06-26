extends RigidBody2D
@onready var anim : AnimationPlayer = $AnimationPlayer 
@onready var area : Area2D = $Area2D
@onready var shape: CollisionShape2D = $CollisionShape2D
var item: ItemData = null
var target : Node2D = null
var chase_time = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("default")
	pass # Replace with function body.
	
func set_resource(resource):
	item = resource
	print(item)

func chase(delta):
	gravity_scale = 0
	shape.disabled = true
	var dir = (target.global_position - global_position).normalized()
	var dist = global_position.distance_to(target.global_position)
	var speed = chase_time * 100
	apply_impulse(dir * speed)
	chase_time += delta
	if dist < 40:
		scale = Vector2(dist / 40.0, dist / 40.0)
	if dist < 10:
		target.pickup_item(item)
		queue_free()
	#linear_velocity *=  0.99
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	for body in area.get_overlapping_bodies():
		if body.has_method("is_player"):
			target = body
	if target:
		chase(delta)
	pass
