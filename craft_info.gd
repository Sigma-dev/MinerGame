extends PanelContainer

@onready var ingredients = $HBoxContainer/Ingredients
@onready var item_texture = $HBoxContainer/VBoxContainer2/ItemTexture
@onready var item_description = $HBoxContainer/VBoxContainer2/ItemDescription
var ingredient_scene = preload("res://craft_info_ingredient.tscn")

func set_craft_info(craft_data: CraftData):
	for ingredient in craft_data.recipe:
		var instance = ingredient_scene.instantiate()
		ingredients.add_child(instance)
