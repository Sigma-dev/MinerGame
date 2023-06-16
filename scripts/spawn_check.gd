extends Area2D

var checked = false
var manager = null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_manager(new_manager):
	manager = new_manager

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if checked:
		return
	var overlap = get_overlapping_bodies()
	if overlap.size() > 0:
		manager.spawn_on_random_ground()
		queue_free()
	else:
		manager.spawn_at_pos(global_position)
	pass
