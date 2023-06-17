extends CharacterBody2D

const FLOAT_EPSILON = 0.01

@onready var shape = $CollisionShape2D
@onready var ray_bot: RayCast2D = $RayBot
@onready var ray_right: RayCast2D = $RayRight
var settled = false
var rotating = 0
var current = 0
var touched_ground_again = false

static func compare_floats(a, b, epsilon = FLOAT_EPSILON):
	var diff =  abs(a - b)
	print(diff)
	return diff <= epsilon

func raycast(origin, target):
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(origin, target)
	return space_state.intersect_ray(query)

func wait_settle():
	if !settled && ray_bot.get_collider():
		settled = true
	return settled
func _physics_process(delta):
	if !wait_settle():
		return
	if ray_bot.get_collider():
		touched_ground_again = true
	if !ray_bot.get_collider() && touched_ground_again && rotating == 0:
		rotating = 1
	if ray_right.get_collider() && touched_ground_again && rotating == 0:
		rotating = -1
	if rotating != 0:
		var t_rot = (current + (90 * rotating)) % 360 
		var quat = Quaternion.from_euler(Vector3(0, 0, deg_to_rad(rotation_degrees)))
		var target = Quaternion.from_euler(Vector3(0, 0, deg_to_rad(t_rot)))
		rotation_degrees = rad_to_deg(quat.slerp(target, 0.5).get_euler().z)
		print("start")
		var rot = int(round(rotation_degrees))
		print (rot)
		print (t_rot)
		if (rot - t_rot) % 360 == 0:
			touched_ground_again = false
			current = t_rot
			rotating = 0
		return
	velocity = transform.x * 200
	
	move_and_slide()




