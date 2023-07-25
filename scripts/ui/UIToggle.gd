class_name UIStatus

extends Control
static var enabled = false

func _ready():
	modulate.a = 0

func _process(delta):
	modulate.a = lerp(modulate.a, 1.0 if enabled else 0.0, 0.1)
	if Input.is_action_just_pressed("inventory"):
		enabled = !enabled
	pass
