extends VBoxContainer
@export var recipes_data: CraftRecipesData
var craft_scene = preload("res://craft.tscn")

func _ready():
	print(recipes_data.recipes[0].ingredients)
	for recipe in recipes_data.recipes:
		var instance = craft_scene.instantiate()
		instance.set_data(recipe)
		add_child(instance)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
