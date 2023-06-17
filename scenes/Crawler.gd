extends CharacterBody2D

const FLOAT_EPSILON = 0.001

@onready var right_bound = $Bounds/Right
@onready var left_bound = $Bounds/Left
@onready var shape = $CollisionShape2D
@onready var line: Line2D = get_parent()
@onready var ray_left: RayCast2D = $RayLeft
@onready var ray_mid: RayCast2D = $RayMid
@onready var ray_right: RayCast2D = $RayRight


var settled = false
var base_rotation = 0.0

static func compare_floats(a, b, epsilon = FLOAT_EPSILON):
	return abs(a - b) <= epsilon

func raycast(origin, target):
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(origin, target)
	return space_state.intersect_ray(query)

func get_target_rotation_offset():
	if ray_right.get_collider():
		return 1.0
	var left = ray_left.global_position
	var right = ray_right.global_position
	for n in 10:
		ray_mid.global_position = (left + right) / 2
		ray_mid.force_raycast_update()
		if ray_mid.get_collider():
			left = ray_mid.global_position
		else:
			right = ray_mid.global_position
	var d_left =  ray_left.global_position.distance_to(ray_mid.global_position)
	var d_total = ray_left.global_position.distance_to(ray_right.global_position)
	return d_left / d_total 
		
		

func _physics_process(delta):
	
	#var target_rotation_offset = get_target_rotation_offset() 
	#rotation_degrees = lerp(rotation_degrees, base_rotation + target_rotation_offset, 0.1)
	velocity = transform.x * 10
	move_and_slide()

	var offset = get_target_rotation_offset()
	if compare_floats(offset, 1.0) || settled == true:
		settled = true
	else:

		return
	if (compare_floats(offset, 0)):
		base_rotation += 90
		print("thrusting")
		velocity = transform.y * 10
		
	print(velocity)
	rotation_degrees = lerp(rotation_degrees, base_rotation + 90 - get_target_rotation_offset() * 90, 0.1)
	print(offset)
	move_and_slide()
		#-transform.basis.x 
		# use global coordinates, not local to node
		
	# Add the gravity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.



