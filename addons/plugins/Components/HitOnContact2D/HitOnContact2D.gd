@tool
class_name HitOnContact2D
extends Node2D

@export var damage = 10

func _physics_process(delta):
	var count = get_parent().get_slide_collision_count() 
	for i in count:
		var hit_info = get_parent().get_slide_collision(i)
		for child in hit_info.get_collider().get_children():
			if child is Hittable:
				child.try_hit(damage, hit_info.get_position())
