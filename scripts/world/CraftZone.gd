extends Node2D

@export var craft_zone : CraftZoneData = null
@onready var sprite = $Sprite

func get_data() -> CraftZoneData:
	return craft_zone

func _process(delta):
	craft_zone.process(delta)
	sprite.texture = craft_zone.get_texture()
