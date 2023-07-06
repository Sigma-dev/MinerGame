extends Control

var slot_scene : PackedScene = preload("res://scenes/ui/inventory/inventory_slot.tscn")
@export var inventory_data: InventoryData = null
@onready var slots = $HBoxContainer/PanelContainer/MarginContainer/Slots
@onready var item_texture = $HBoxContainer/SlotInfo/MarginContainer2/PanelContainer/Container/ItemTexture
@onready var item_name = $HBoxContainer/SlotInfo/MarginContainer2/PanelContainer/Container/ItemName
@onready var action_button : Button = $HBoxContainer/SlotInfo/MarginContainer2/PanelContainer/Container/ActionButton

var selected_slot : SlotData = null
@onready var slot_info = $HBoxContainer/SlotInfo
var construction_cursor_scene = preload("res://scenes/prefabs/ConstructionCursor.tscn")
var construction_cursor = null
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
	if !(inventory_data.slots.has(selected_slot)):
		selected_slot = null
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
		if selected_slot.item_data.construction != null:
			action_button.pressed.connect(try_spawn_cursor)
			
func try_spawn_cursor():
	if (construction_cursor != null || is_instance_valid(construction_cursor)):
		return
	print("spawned")
	construction_cursor = construction_cursor_scene.instantiate()
	construction_cursor.set_data(selected_slot.item_data, inventory_data)
	owner.get_parent().add_child(construction_cursor)
	pass
	
func on_slot_selected(slot_data: SlotData):
	if construction_cursor:
		construction_cursor.queue_free()
	selected_slot = slot_data
	_update()

