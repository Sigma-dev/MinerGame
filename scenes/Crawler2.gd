extends CharacterBody2D

const FLOAT_EPSILON = 0.01

@onready var shape = $CollisionShape2D
@onready var ray_bot: RayCast2D = $RayBot
var settled = false
var rotating = false
var current = 0.0
var touched_ground_again = false

static func compare_floats(a, b, epsilon = FLOAT_EPSILON):
	var diff =  abs(a - b)
	print(diff)
	return diff <= epsilon

func raycast(origin, target):
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(origin, target)
	return space_state.intersect_ray(query)

func _physics_process(delta):
	if !settled && ray_bot.get_collider():
		settled = true
	if ray_bot.get_collider():
		touched_ground_again = true
	if !settled:
		return
	if !ray_bot.get_collider() && touched_ground_again:
		rotating = true
	if rotating:
		var quat = Quaternion.from_euler(Vector3(0, 0, deg_to_rad(rotation_degrees)))
		var target = Quaternion.from_euler(Vector3(0, 0, deg_to_rad(current + 90)))
		rotation_degrees = rad_to_deg(quat.slerp(target, 0.3).get_euler().z)
		print("start")

		if (rotation_degrees < 0):
			rotation_degrees += 360
		#rotation_degrees = lerp(rotation_degrees, current + 90, 0.3)
		var rot = fmod(rotation_degrees, 359.9999)
		var t_rot = fmod(current + 90.0, 359.9999)
		print (rot)
		print( t_rot)
		if compare_floats(rot, t_rot):
			touched_ground_again = false
			current += 90.0
			rotating = false
		return
	velocity = transform.x * 100
	
	move_and_slide()




