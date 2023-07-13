extends Resource

class_name SlotData

@export var quantity = 0:
	set(new_val):
		quantity = new_val
		on_update.emit()
@export var item_data: ItemData = null:
	set(new_val):
		item_data = new_val
		on_update.emit()
var uuid : int = -1
static var generator = 0

signal on_update

static func create(item : ItemData = null, amount : int = 0):
	var slot = SlotData.new()
	slot.item_data = item
	slot.quantity = amount
	generator += 1
	slot.uuid = generator
	return slot

func copy(to_copy: SlotData):
	if to_copy.is_empty():
		return
	item_data = to_copy.item_data
	quantity = to_copy.quantity
	on_update.emit()

func clear():
	item_data = null
	quantity = 0
	on_update.emit()

func is_empty():
	return item_data == null || quantity == 0
