extends Resource
class_name CraftingRecipesData

@export var recipes : Array[CraftingRecipeData]

func find_possible_craft(inv: InventoryData):
	for recipe in recipes:
		if recipe.can_craft(inv):
			return recipe
	return null
