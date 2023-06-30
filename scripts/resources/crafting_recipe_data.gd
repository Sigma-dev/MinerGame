extends Resource
class_name CraftingRecipeData

@export var ingredients : Array[SlotData]
@export var product : ItemData
@export var produced_amount = 1

func can_craft(inventory: InventoryData):
	for ingredient in ingredients:
		if (inventory.get_amount_item(ingredient.item_data) < ingredient.quantity):
			return false
	return true
	
func craft(inventory: InventoryData):
	if !can_craft(inventory):
		return null
	for ingredient in ingredients:
		inventory.remove_item_quantity(ingredient.item_data, ingredient.quantity)
	return inventory.add_item(product, produced_amount)
