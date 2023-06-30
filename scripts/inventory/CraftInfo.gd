extends PanelContainer

@onready var ingredients = $MarginContainer/VBoxContainer/HBoxContainer/Ingredients
@onready var item_texture = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/ItemTexture
@onready var item_description = $MarginContainer/VBoxContainer/HBoxContainer/ItemDescription
@onready var item_name = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/ItemName
@onready var craft_button : Button = $MarginContainer/VBoxContainer/CraftButton
var player_inventory = preload("res://resources/default/player_inventory.tres")
var ingredient_scene = preload("res://scenes/ui/craft_info_ingredient.tscn")
var crafting_recipe: CraftingRecipeData = null

func _ready():
	craft_button.button_down.connect(_craft)
	player_inventory.on_update.connect(update)
	
func _craft():
	crafting_recipe.craft(player_inventory)

func update(): 
	for child in ingredients.get_children():
		child.queue_free()
	for ingredient in crafting_recipe.ingredients:
		var instance = ingredient_scene.instantiate()
		ingredients.add_child(instance)
		instance.set_data(ingredient)
	item_name = crafting_recipe.product.name
	item_texture.texture = crafting_recipe.product.texture
	item_description.text = crafting_recipe.product.hint
	craft_button.visible = crafting_recipe.can_craft(player_inventory)

func set_craft_info(new_crafting_recipe: CraftingRecipeData):
	crafting_recipe = new_crafting_recipe
	update()
