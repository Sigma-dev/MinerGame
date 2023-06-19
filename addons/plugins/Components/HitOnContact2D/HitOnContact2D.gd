@tool
class_name HitOnContact2D
extends Node2D

@export var damage = 10
@export var only_affect_player = false

func _physics_process(delta):
	var count = get_parent().get_slide_collision_count() 
	for i in count:
		var hit_info = get_parent().get_slide_collision(i)
		var hit = hit_info.get_collider()
		for child in hit.get_children():
			if child is Hittable:
				if only_affect_player && !hit.get_groups().has("Player"):
					continue
				child.try_hit(damage, hit_info.get_position())
