@tool
extends Node2D

class Zone:
	var spawn: Node2D
	var spawned: bool
	var coords: Vector2i
	
	func _init(new_spawn, new_coords):
		self.spawn = new_spawn
		self.coords = new_coords

var player = null
var zones : Array[Zone] = []

func deploy_zone_at(coords: Vector2i):
	for zone in zones:
		if zone.spawned == false && zone.coords == coords:
			zone.spawn.deploy()
			zone.spawned = true
			return

func add_zone_spawner(spawn, coords):
	zones.append(Zone.new(spawn, coords))
