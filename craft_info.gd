extends PanelContainer

@onready var ingredients = $MarginContainer/VBoxContainer/HBoxContainer/Ingredients
@onready var item_texture = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/ItemTexture
@onready var item_description = $MarginContainer/VBoxContainer/HBoxContainer/ItemDescription
@onready var item_name = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2/ItemName
@onready var craft_button : Button = $MarginContainer/VBoxContainer/CraftButton
var player_inventory = preload("res://resources/default/player_inventory.tres")
var ingredient_scene = preload("res://craft_info_ingredient.tscn")
var craft_data: CraftData = null

func _ready():
	craft_button.button_down.connect(_craft)
	player_inventory.on_update.connect(update)
	
func _craft():
	craft_data.craft(player_inventory)

func update(): 
	for child in ingredients.get_children():
		child.queue_free()
	for ingredient in craft_data.ingredients:
		var instance = ingredient_scene.instantiate()
		ingredients.add_child(instance)
		instance.set_data(ingredient)
	item_name = craft_data.result.name
	item_texture.texture = craft_data.result.texture
	item_description.text = craft_data.result.hint
	craft_button.visible = craft_data.can_craft(player_inventory)

func set_craft_info(new_craft_data: CraftData):
	craft_data = new_craft_data
	update()
