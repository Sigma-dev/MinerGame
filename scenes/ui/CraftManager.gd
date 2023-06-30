extends VBoxContainer
@export var recipes_data: CraftRecipesData
var craft_scene = preload("res://scenes/ui/craft.tscn")
@onready var craft_info = $CraftInfo

func _ready():
	craft_info.set_craft_info(recipes_data.recipes[0])
	for recipe in recipes_data.recipes:
		var instance = craft_scene.instantiate()
		add_child(instance)
		instance.set_data(recipe)

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
