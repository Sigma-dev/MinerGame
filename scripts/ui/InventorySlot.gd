extends Button
class_name InventorySlot
@onready var label : Label = $Label
@onready var texture = $MarginContainer/TextureRect

var slot_data : SlotData
signal on_slot_selected(slot, index)
signal on_data_changed(slot_data, index)

func _ready():
	pressed.connect(on_select)

func set_data(new_slot_data: SlotData):
	slot_data = new_slot_data
	if slot_data.is_empty():
		return
	var text = slot_data.item_data.texture
	texture.texture = text
	label.text =  "x" + str(slot_data.quantity)
	label.visible = true

func _process(delta):
	pass

func on_select():
	assert(slot_data != null, "All slot_data should be non null, usually by the inventory containing it")
		
	on_slot_selected.emit()
	var carried = ConstructionCursor.get_slot_data()
	ConstructionCursor.set_data(slot_data.duplicate(), null, get_tree().root.get_child(0))
	if (carried && !slot_data.is_empty() && !carried.is_empty() && slot_data.item_data.name == carried.item_data.name):
		slot_data.quantity += carried.quantity
		ConstructionCursor.set_data(SlotData.create(), null, get_tree().root.get_child(0))
	else:

		slot_data.clear()
		#on_data_changed.emit(null)
		if !carried.is_empty():
			#if(!slot_data):
			#	slot_data = SlotData.create()
			slot_data.copy(carried)
		

		#var previous_slot = inventory_data.place_slot_at(construction_cursor.get_slot_data(), slot_index)
		##construction_cursor.queue_free()
	##selected_slot = slot_data
	#if (selected_slot):

