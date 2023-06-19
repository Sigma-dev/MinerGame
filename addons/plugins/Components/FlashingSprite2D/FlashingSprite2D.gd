@tool
class_name FlashingSprite2D
extends Sprite2D
@export var decay_rate = 0.05
var flash_remaining = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	material = ShaderMaterial.new()
	material.shader = preload("flash.gdshader")
	pass # Replace with function body.

func flash(a = 0, b = 0, c = 0, d = 0, e = 0, f = 0):
	flash_remaining = 1.0

func _process(delta):
	material.set_shader_parameter("flash_amount", flash_remaining)
	if flash_remaining > 0:
		flash_remaining -= decay_rate
	if flash_remaining < 0:
		flash_remaining = 0
