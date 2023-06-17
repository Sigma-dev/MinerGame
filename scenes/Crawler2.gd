extends CharacterBody2D

const FLOAT_EPSILON = 0.01

@onready var shape = $CollisionShape2D
@onready var ray_bot: RayCast2D = $RayBot
@onready var ray_mid: RayCast2D = $RayMid
@onready var ray_right: RayCast2D = $RayRight
var settled = false
var rotating = 0
var current = 0
var touched_ground_again = false
var visual_angle = 0
var edge_size = 0

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
	#if !ray_mid.get_collider() && ray_bot.get_collider() && touched_ground_again:
		#visual_angle = current + 45
	if get_raycast_distance(ray_right) > 4 && get_raycast_distance(ray_right) <= 10:
		visual_angle = current + -90
	if get_raycast_distance(ray_right) <= 4 && touched_ground_again && rotating == 0:
		rotating = -1
	if rotating != 0:
		var t_rot = (current + (90 * rotating)) % 360 
		var target = Quaternion.from_euler(Vector3(0, 0, deg_to_rad(t_rot)))
		rotation_degrees = rad_to_deg(target.get_euler().z)
		touched_ground_again = false
		current = t_rot
		visual_angle = current
		rotating = 0
		print("rotated")
	else:
		edge_size = get_edge_size()
		if touched_ground_again && edge_size > 0:
			print("edge set")
			visual_angle = current + edge_size * 90
			print(visual_angle)
	print("start")
	print(visual_angle)
	velocity = transform.x * 20 #default 20
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
	var edge =  ray_mid.global_position.distance_to(right_pos)
	var length = ray_bot.global_position.distance_to(right_pos)
	ray_mid.global_position = right_pos
	return (edge / length)

func get_raycast_distance(ray: RayCast2D):
	return ray.global_position.distance_to(ray.get_collision_point())

func get_visual_angle():
	return visual_angle

func _draw():
	draw_set_transform(Vector2(0.0, 0.0), 0)
	#var local_pos = ray_bot.global_position + ray_bot.global_position.direction_to(ray_mid.global_position) * edge_size
	#draw_circle_arc_poly(local_pos - global_position, 10, 0, 359, Color.WHITE)

func draw_circle_arc_poly(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PackedVector2Array()
	points_arc.push_back(center)
	var colors = PackedColorArray([color])

	for i in range(nb_points + 1):
		var angle_point = deg_to_rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	draw_polygon(points_arc, colors)




