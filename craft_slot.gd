extends Button
@onready var ingredient_texture = $HBoxContainer/Ingredients/IngredientTexture
@onready var craft_result_name = $HBoxContainer/HBoxContainer3/CraftResultName
@onready var craft_result_texture = $HBoxContainer/HBoxContainer3/CraftResultTexture
@onready var ingredients = $HBoxContainer/Ingredients
var craft_data : CraftData = null

signal on_craft_select(craft_data)
# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(self._button_pressed)
	pass # Replace with function body.
	
func _button_pressed():
	on_craft_select.emit(craft_data)

func set_data(new_craft_data: CraftData):
	craft_data = new_craft_data
	update()
	
func update():
	for ingredient in craft_data.ingredients:
		var instance = ingredient_texture.duplicate()
		ingredients.add_child(instance)
		instance.texture = ingredient.item_data.texture
		instance.visible = true
	craft_result_name.text = craft_data.result.name
	craft_result_texture.texture = craft_data.result.texture

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
