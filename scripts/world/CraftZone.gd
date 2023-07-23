class_name Construction
extends Node2D

@export var construction_item : ItemData = null
@onready var sprite = $Sprite

func get_data() -> CraftZoneData:
	return construction_item.construction.craft_zone
	
func get_item_data() -> ItemData:
	return construction_item

func _process(delta):
	construction_item.construction.craft_zone.process(delta)
	sprite.texture = construction_item.construction.craft_zone.get_texture()
