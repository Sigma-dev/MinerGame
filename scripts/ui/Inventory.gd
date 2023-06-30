extends Control

var slot_scene : PackedScene = preload("res://scenes/ui/inventory/inventory_slot.tscn")
@export var inventory_data: InventoryData = null
@onready var slots = $HBoxContainer/PanelContainer/MarginContainer/Slots
@onready var item_texture = $HBoxContainer/SlotInfo/MarginContainer2/PanelContainer/Container/ItemTexture
@onready var item_name = $HBoxContainer/SlotInfo/MarginContainer2/PanelContainer/Container/ItemName
@onready var action_button = $HBoxContainer/SlotInfo/MarginContainer2/PanelContainer/Container/ActionButton

var selected_slot : SlotData = null
@onready var slot_info = $HBoxContainer/SlotInfo

# Called when the node enters the scene tree for the first time.
func _ready():
	if inventory_data:
		set_inventory_data(inventory_data)	
		_update()
	pass # Replace with function body.

func set_inventory_data(new_data: InventoryData):
	inventory_data = new_data
	inventory_data.on_update.connect(_update)

func _update():
	if !inventory_data:
		return
	for child in slots.get_children():
		child.queue_free()
	for slot_data in inventory_data.slots:
		var instance = slot_scene.instantiate()
		slots.add_child(instance)
		instance.on_slot_selected.connect(on_slot_selected)
		if slot_data:
			instance.set_data(slot_data)
	slot_info.visible = selected_slot != null
	if selected_slot:
		item_texture.texture = selected_slot.item_data.texture
		item_name.text = selected_slot.item_data.name
		action_button.visible = selected_slot.item_data.construction != null
			
func on_slot_selected(slot_data: SlotData):
	selected_slot = slot_data
	_update()

