extends PanelContainer

@onready var ingredients = $MarginContainer/VBoxContainer/HBoxContainer/Ingredients
@onready var item_texture = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/ItemTexture
@onready var item_description = $MarginContainer/VBoxContainer/HBoxContainer/ItemDescription
@onready var item_name = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/ItemName
@onready var craft_button = $MarginContainer/VBoxContainer/CraftButton

var ingredient_scene = preload("res://craft_info_ingredient.tscn")
var craft_data = null
func update(): 
	for ingredient in craft_data.ingredients:
		var instance = ingredient_scene.instantiate()
		ingredients.add_child(instance)
		instance.set_data(ingredient)
	item_name = craft_data.result.name
	item_texture.texture = craft_data.result.texture
	item_description.text = craft_data.result.hint

func set_craft_info(new_craft_data: CraftData):
	craft_data = new_craft_data
	update()
