@tool
class_name Hittable
extends Node

signal get_hit(damage, point)
signal get_hit_point(point)

func hit(damage, point = null):
	get_hit.emit(damage, point)
	get_hit_point.emit(point)

