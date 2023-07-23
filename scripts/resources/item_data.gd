extends Resource

class_name ItemData

@export var name = ""
@export var hint = ""
@export var stackable = true 
@export var texture: AtlasTexture
@export var attributes: Array[ItemAttributeData] = []
@export var construction : ConstructionData = null
