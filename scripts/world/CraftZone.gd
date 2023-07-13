extends Node2D

@export var craft_zone : CraftZoneData = null

func get_data() -> CraftZoneData:
	return craft_zone

func _process(delta):
	craft_zone.process(delta)
