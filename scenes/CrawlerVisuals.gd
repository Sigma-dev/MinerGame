extends Sprite2D

var target = 0
var local = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#local = lerp(local, float(target), 0.05)
	#var fart = Quaternion.from_euler(Vector3(0, 0, deg_to_rad(local)))
	#global_rotation = fart.get_euler().z
	var t_rot = target
	var quat = Quaternion.from_euler(Vector3(0, 0, deg_to_rad(local)))
	var fart = Quaternion.from_euler(Vector3(0, 0, deg_to_rad(t_rot)))
	#global_rotation = quat.slerp(fart, 0.1).get_euler().z
	local = rad_to_deg(global_rotation)
	print("rot")
	print(rad_to_deg(global_rotation))

	target = get_parent().get_visual_angle()

	#print("stae")
	#print(target)
	#print(global_rotation)
	pass
