extends Control

var slot_scene : PackedScene = preload("res://scenes/ui/inventory/inventory_slot.tscn")
@export var inventory_data: InventoryData = null
@onready var slots = $HBoxContainer/PanelContainer/MarginContainer/Slots
@onready var slot_info_texture = $HBoxContainer/SlotInfo/MarginContainer2/PanelContainer/Container/ItemTexture
@onready var slot_info_name = $HBoxContainer/SlotInfo/MarginContainer2/PanelContainer/Container/ItemName
@onready var action_button : Button = $HBoxContainer/SlotInfo/MarginContainer2/PanelContainer/Container/ActionButton

var selected_slot : SlotData = null
@onready var slot_info = $HBoxContainer/SlotInfo

func _ready():
	if inventory_data:
		set_inventory_data(inventory_data)	
		_update()

func set_inventory_data(new_data: InventoryData):
	inventory_data = new_data
	inventory_data.on_update.connect(_update)

func _update():
	if !inventory_data:
		return
	if !(inventory_data.slots.has(selected_slot)):
		selected_slot = null
	update_slots()
	update_slot_info()

func update_slots():
	for child in slots.get_children():
		child.queue_free()
	for slot_data in inventory_data.slots:
		var instance : InventorySlot = slot_scene.instantiate()
		slots.add_child(instance)
		instance.set_data(slot_data)

func update_slot_info():
	slot_info.visible = selected_slot != null
	if selected_slot:
		slot_info.update(selected_slot.item_data)
		action_button.visible = selected_slot.item_data.construction != null


