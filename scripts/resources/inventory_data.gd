extends Resource
class_name InventoryData

signal on_update
@export var slots : Array[SlotData] = []:
	set(new_val): 
		slots = new_val
		on_slots_change()

func _init():
	on_slots_change()
	
	
func clear():
	slots = []

func on_slots_change():
	for i in slots.size():
		if !slots[i]:
			slots[i] = SlotData.create()
		slots[i].on_update.connect(on_slot_update)

func on_slot_update():
	on_update.emit()

func find_or_create_item_slot(item: ItemData) -> SlotData:
	for slot in slots:
		if(slot.item_data == item):
			return slot
	for slot in slots:
		if(slot.is_empty()):
			slot.item_data = item
			return slot
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
	
func remove_item_quantity(item_data, quantity):
	var to_remove = quantity
	for slot in slots:
		if(slot && slot.item_data == item_data):
			if slot.quantity > to_remove:
				slot.quantity -= to_remove
				break
			else:
				to_remove -= slot.quantity
				slot.clear()
	on_update.emit()
	
func get_slot_index(slot: SlotData) -> int:
	return slots.find(slot)

func place_slot_at(slot: SlotData, index: int) -> SlotData:
	var old = slots[index]
	slots[index] = slot
	return old
		
func remove_any_item() -> ItemData:
	for slot in slots:
		if !slot.is_empty() && slot.quantity > 0:
			slot.quantity -= 1
			return slot.item_data
	return null
			
