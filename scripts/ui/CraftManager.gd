extends VBoxContainer
@export var recipes_data: CraftingRecipesData
var craft_scene = preload("res://scenes/ui/crafting/crafting_recipe.tscn")
@onready var craft_info = $CraftInfo

func _ready():
	craft_info.set_craft_info(recipes_data.recipes[0])
	for recipe in recipes_data.recipes:
		var instance = craft_scene.instantiate()
		add_child(instance)
		instance.set_data(recipe)
		instance.on_craft_select.connect(on_craft_select)
	pass # Replace with function body.

func on_craft_select(craft_data: CraftingRecipeData):
	craft_info.set_craft_info(craft_data)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
