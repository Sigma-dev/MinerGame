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
	
func craft(input_inv: InventoryData, output_inv: InventoryData):
	if !can_craft(input_inv):
		return null
	for ingredient in ingredients:
		input_inv.remove_item_quantity(ingredient.item_data, ingredient.quantity)
	return output_inv.add_item(product, produced_amount)
