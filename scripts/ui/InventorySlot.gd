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
	var txt = slot_data.item_data.texture
	texture.texture = txt
	label.text =  "x" + str(slot_data.quantity)
	label.visible = true

func on_select():
	assert(slot_data != null, "All slot_data should be non null, usually by the inventory containing it")
	on_slot_selected.emit()
	var carried = ConstructionCursor.get_slot_data()
	if (!carried.is_empty()) && !(slot_data.item_filter.call(carried.item_data)):
		return
	ConstructionCursor.set_data(slot_data.duplicate(), get_tree().root.get_child(0))
	if (carried && !slot_data.is_empty() && !carried.is_empty() && slot_data.item_data.name == carried.item_data.name):
		slot_data.quantity += carried.quantity
		ConstructionCursor.set_data(SlotData.create(), get_tree().root.get_child(0))
	else:
		slot_data.clear()
		ConstructionCursor.instance.update()
		if !carried.is_empty():
			slot_data.copy(carried)
