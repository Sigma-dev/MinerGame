extends Resource
class_name CraftZoneData

var ingredients_inv : InventoryData = InventoryData.new()
var fuel_inv : InventoryData = InventoryData.new()
var products_inv : InventoryData = InventoryData.new()
@export var crafting_recipes : CraftingRecipesData = CraftingRecipesData.new():
	set(new_val):
		crafting_recipes = new_val
		_update_inventories()
@export var fuel : ItemData = null:
	set(new_val):
		fuel = new_val
		_update_inventories()
@export var range : int = 32

func _update_inventories():
	ingredients_inv.clear()
	fuel_inv.clear()
	products_inv.clear()
	for recipe in crafting_recipes.recipes:
		for ingredient in recipe.ingredients:
			ingredients_inv.slots += [SlotData.create()]
		products_inv.slots += [SlotData.create()]
	if fuel:
		fuel_inv.slots += [SlotData.create()]

