extends Camera2D

var player = null

func _ready():
	player = get_tree().get_nodes_in_group("Player")[0]

func get_target_pos():
	return player.global_position
	var zone_width = 512
	var zone_height = 276
	var relative_to_zone = Vector2(fmod(player.global_position.x, zone_width), fmod(player.global_position.y, zone_height))
	print(relative_to_zone)
	if abs(relative_to_zone.y) > zone_height / 3:
		return player.global_position
	if abs(relative_to_zone.x) > zone_width / 3:
		return player.global_position
	return player.global_position - relative_to_zone

func _physics_process(delta):
	var target_pos = get_target_pos()
	if target_pos == null:
		return
	global_position = lerp(global_position, target_pos, 0.05)
	pass
