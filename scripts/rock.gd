extends Node2D

@export var sparks: PackedScene
@export var drop: PackedScene
@onready var flashing_sprite = $FlashingSprite2D
@onready var health = $Health

func _ready():
	health.die.connect(die)

func get_hit(damage, point = null):
	health.damage(damage)
	hit_visuals(damage, point)
	
func die():
	var d = drop.instantiate()
	d.global_position = global_position
	get_parent().add_child(d);

func hit_visuals(damage, point):
	var particles = sparks.instantiate()
	get_parent().add_child(particles);
	particles.global_position = point if point else Vector2.ZERO
	#flashing_sprite.flash()
