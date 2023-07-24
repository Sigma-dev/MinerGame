extends Resource
class_name ConstructionData

static var construction = preload("res://scenes/prefabs/resource_dependent/Construction.tscn")
@export var height = 1
@export var preview_texture : Texture2D = null
@export var craft_zone : CraftZoneData = null
