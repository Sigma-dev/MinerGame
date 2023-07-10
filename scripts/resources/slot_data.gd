extends Resource

class_name SlotData

@export var quantity = 0
@export var item_data: ItemData = null
@export var uuid : int = -1
static var generator = 0

static func create(item : ItemData, amount : int = 0):
	var slot = SlotData.new()
	slot.item_data = item
	slot.quantity = amount
	generator += 1
	slot.uuid = generator
	return slot

func clear():
	item_data = null
	quantity = 0
	
