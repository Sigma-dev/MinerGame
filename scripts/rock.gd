extends Node2D

@onready var particles: CPUParticles2D = $CPUParticles2D
@export var sparks: PackedScene
@onready var sprite: Sprite2D = $Sprite2D
var hp = 30
var particles_to_destroy = []
var flash_amount = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_hit(damage, point = null):
	hit_visuals(damage, point)
	hp -= damage
	if hp <= 0:
		queue_free()
	flash_amount = 1
	
func hit_visuals(damage, point):
	var particles = sparks.instantiate()
	particles.global_position = Vector2.ZERO
	add_child(particles);
	if (point != null):
		particles.global_position = point
	particles.emitting = true
	particles_to_destroy += [particles]
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for p in particles_to_destroy:
		if p.emitting == false:
			p.queue_free()
			particles_to_destroy.erase(p)
	sprite.material.set_shader_parameter("flash_amount", flash_amount)
	if flash_amount > 0:
		flash_amount -= 0.05
	if flash_amount < 0:
		flash_amount = 0
	pass
