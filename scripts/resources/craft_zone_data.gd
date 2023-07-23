extends Resource
class_name CraftZoneData

var ingredients_inv : InventoryData = InventoryData.new()
var fuel_inv : InventoryData = InventoryData.new()
var products_inv : InventoryData = InventoryData.new()
@export var processing_time : float = 1.0
@export var crafting_recipes : CraftingRecipesData = CraftingRecipesData.new():
	set(new_val):
		crafting_recipes = new_val
		update_inventories()
@export var range : int = 32
@export var idle_anim : TileAnimation = null
@export var fuel_present_anim : TileAnimation = null
@export var fuel_burning_anim : TileAnimation = null
@export var fuel_attributes: Array[ItemAttributeData] = []:
	set(new_val):
		fuel_attributes = new_val
		update_inventories()
var progress = 0
var fuel_remaining = 0
var current_recipe = null
var current_texture : Texture = null
var anim_time =0.3
var time_till_next_anim = anim_time
var anim_index = 0

func get_texture():
	if current_texture:
		return current_texture
	return idle_anim.get_current_frame()

func process(delta):
	fuel_burning_anim.run(delta)
	fuel_present_anim.run(delta)
	idle_anim.run(delta)
	current_texture = idle_anim.get_current_frame()
	if fuel_inv.get_item_count() > 0:
		current_texture = fuel_present_anim.get_current_frame()
	if !current_recipe:
		current_recipe = crafting_recipes.find_possible_craft(ingredients_inv)
		if !current_recipe:
			return
	if (current_recipe):
		if fuel_remaining > 0:
			#current_texture = fuel_burning_anim[anim_index % fuel_burning_anim.size()]
			current_texture = fuel_burning_anim.get_current_frame()
			fuel_remaining -= 0.02
			progress += 0.005
			if progress >= 1:
				progress = 0
				current_recipe.craft(ingredients_inv, products_inv)
				current_recipe = null
			pass
		else:
			var fuel = fuel_inv.remove_any_item()
			if fuel:
				for attribute in fuel_attributes:
					for att in fuel.attributes:
						if att == attribute:
							fuel_remaining += att.value
		

func uses_fuel():
	if fuel_attributes.size() == 0:
		return false
	return true

func update_inventories():
	ingredients_inv.clear()
	fuel_inv.clear()
	products_inv.clear()
	for recipe in crafting_recipes.recipes:
		for ingredient in recipe.ingredients:
			ingredients_inv.slots += [SlotData.create()]
		products_inv.slots += [SlotData.create()]

	if uses_fuel():
		var data = SlotData.create()
		data.item_filter = func(item_data: ItemData): 
			for att in fuel_attributes:
				if item_data.attributes.all(func(item_attribute: ItemAttributeData): item_attribute.name != att.name):
					return false
			return true
		fuel_inv.slots += [data]

