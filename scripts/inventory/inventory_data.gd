extends Resource
class_name InventoryData

signal on_update
@export var slots : Array[SlotData]

func find_or_create_item_slot(item: ItemData) -> SlotData:
	for slot in slots:
		if(slot && slot.item_data == item):
			return slot
	for i in slots.size():
		if(slots[i] == null):
			slots[i] = SlotData.new(item)
			return slots[i]
	return null

func add_item(item_data: ItemData, amount: int = 1):
	var slot = find_or_create_item_slot(item_data)
	if slot:
		slot.quantity += amount
	on_update.emit()
	
func get_amount_item(item_data: ItemData) -> int:
	var amount = 0
	for slot in slots:
		if(slot && slot.item_data == item_data):
			amount += slot.quantity
	return amount
