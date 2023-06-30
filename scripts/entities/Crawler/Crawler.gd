extends CharacterBody2D

const FLOAT_EPSILON = 0.01

@onready var shape = $CollisionShape2D
@onready var ray_bot: RayCast2D = $RayBot
@onready var ray_mid: RayCast2D = $RayMid
@onready var ray_right: RayCast2D = $RayRight
var settled = false
var rotating = 0
var touched_ground_again = false
var visual_angle = 0
@onready var anim = $AnimationPlayer
var edge_size = 0

func _ready():
	anim.play("run")

static func compare_floats(a, b, epsilon = FLOAT_EPSILON):
	var diff =  abs(a - b)
	return diff <= epsilon

func raycast(origin, target):
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(origin, target)
	return space_state.intersect_ray(query)

func wait_settle():
	if !settled && ray_bot.get_collider():
		settled = true
	return settled
	
func handle_visuals(rotated):
	if get_raycast_distance(ray_right) > 4 && get_raycast_distance(ray_right) <= 10:
		visual_angle = rotation_degrees + -90
	edge_size = get_edge_size()
	if touched_ground_again && edge_size > 0:
		visual_angle = rotation_degrees + edge_size * 90
	if rotated:
		visual_angle = rotation_degrees

func rotate_to(rotation):
	rotate(deg_to_rad(rotation))
	touched_ground_again = false

func _physics_process(delta):
	if !wait_settle():
		return
	var rotated = true
	if ray_bot.get_collider():
		touched_ground_again = true
	if !ray_bot.get_collider() && touched_ground_again:
		rotate_to(90)
	elif get_raycast_distance(ray_right) <= 4 && touched_ground_again:
		rotate_to(-90)
	else:
		rotated = false
	handle_visuals(rotated)
	velocity = transform.x * 40 #default 20
	move_and_slide()

func get_edge_size():
	var right_pos = ray_right.global_position
	if ray_mid.get_collider():
		return 0.0
	var left = ray_bot.global_position
	var right = right_pos
	for n in 20:
		ray_mid.global_position = (left + right) / 2
		ray_mid.force_raycast_update()
		if ray_mid.get_collider():
			left = ray_mid.global_position
		else:
			right = ray_mid.global_position
	var edge = ray_mid.global_position.distance_to(right_pos)
	var length = ray_bot.global_position.distance_to(right_pos)
	ray_mid.global_position = right_pos
	return (edge / length)

func get_raycast_distance(ray: RayCast2D):
	return ray.global_position.distance_to(ray.get_collision_point())

func get_visual_angle():
	return visual_angle




