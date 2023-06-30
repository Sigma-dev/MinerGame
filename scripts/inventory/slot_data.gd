extends Resource

class_name SlotData

@export var quantity = 0
@export var item_data: ItemData = null

static func create(item : ItemData, amount : int = 0):
	var slot = SlotData.new()
	slot.item_data = item
	slot.quantity = amount
