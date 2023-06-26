extends Resource
class_name InventoryData

signal on_update
@export var slots : Array[SlotData]

func find_or_create_item_slot(item) -> SlotData:
	for slot in slots:
		if(slot && slot.item_data == item):
			return slot
	for i in slots.size():
		if(slots[i] == null):
			slots[i] = SlotData.new()
			slots[i].item_data = item
			return slots[i]
	return null

func add_item(item_data):
	var slot = find_or_create_item_slot(item_data)
	if slot:
		slot.quantity += 1
	on_update.emit()
