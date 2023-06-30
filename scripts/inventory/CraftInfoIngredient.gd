extends MarginContainer

@onready var quantity = $PanelContainer/CraftInfoIngredient/Quantity
@onready var item_texture = $PanelContainer/CraftInfoIngredient/ItemTexture

func set_data(data: SlotData):
	quantity.text = str(data.quantity)
	item_texture.texture = data.item_data.texture
