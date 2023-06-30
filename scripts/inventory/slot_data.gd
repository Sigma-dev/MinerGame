extends Resource

class_name SlotData

@export var quantity = 0
@export var item_data: ItemData = null

func _init(item : ItemData, amount : int = 0):
	item_data = item
	quantity = amount
