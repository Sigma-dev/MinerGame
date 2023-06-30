extends Button
@onready var ingredient_texture = $HBoxContainer/Ingredients/IngredientTexture
@onready var craft_result_name = $HBoxContainer/HBoxContainer3/CraftResultName
@onready var craft_result_texture = $HBoxContainer/HBoxContainer3/CraftResultTexture
@onready var ingredients = $HBoxContainer/Ingredients
var crafting_recipe : CraftingRecipeData = null

signal on_craft_select(crafting_recipe)
# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(self._button_pressed)
	pass # Replace with function body.
	
func _button_pressed():
	on_craft_select.emit(crafting_recipe)

func set_data(new_crafting_recipe: CraftingRecipeData):
	crafting_recipe = new_crafting_recipe
	update()
	
func update():
	for ingredient in crafting_recipe.ingredients:
		var instance = ingredient_texture.duplicate()
		ingredients.add_child(instance)
		instance.texture = ingredient.item_data.texture
		instance.visible = true
	craft_result_name.text = crafting_recipe.product.name
	craft_result_texture.texture = crafting_recipe.product.texture

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
