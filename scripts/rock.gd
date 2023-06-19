extends Node2D

@export var sparks: PackedScene
@onready var health = $Health
@onready var spark_spawner = $SparkSpawner

func get_hit(damage, point = null):
	health.damage(damage)
	hit_visuals(damage, point)

func hit_visuals(damage, point):
	spark_spawner.spawn_at(point if point else Vector2.ZERO)
