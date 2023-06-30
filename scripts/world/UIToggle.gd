extends Control
var target_opacity = 0

func _ready():
	modulate.a = 0

func _process(delta):
	modulate.a = lerp(modulate.a, float(target_opacity), 0.1)
	if Input.is_action_just_pressed("inventory"):
		target_opacity = 1 - target_opacity
	pass
