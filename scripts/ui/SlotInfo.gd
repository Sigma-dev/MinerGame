extends PanelContainer

@onready var item_texture = $MarginContainer2/PanelContainer/Container/ItemTexture
@onready var item_name = $MarginContainer2/PanelContainer/Container/ItemName

func update(item_data: ItemData):
	item_texture.texture = item_data.texture
	item_name.text = item_data.name
	
