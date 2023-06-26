@tool
class_name Hittable
extends Node

signal get_hit(damage, point)
signal get_hit_point(point)
@export var invulnerability_time = 0
var last_hit = -12000
var elapsed = 0

func _process(delta):
	elapsed += delta

func try_hit(damage, point = null):
	if (last_hit + invulnerability_time >= elapsed):
		return
	get_hit.emit(damage, point)
	get_hit_point.emit(point)
	last_hit = elapsed

