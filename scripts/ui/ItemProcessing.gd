extends PanelContainer
class_name ItemProcessing

var craft_zone : CraftZoneData = null
var slot_scene : PackedScene = preload("res://scenes/ui/inventory/inventory_slot.tscn")
@onready var fuel_slots = $MarginContainer/HBoxContainer/VBoxContainer/fuel_slots
@onready var products_slots = $MarginContainer/HBoxContainer/ProductsSlots
@onready var ingredients_slots = $MarginContainer/HBoxContainer/IngredientsSlots
var target_opacity : float = 1.0
@onready var progress_bar = $MarginContainer/HBoxContainer/VBoxContainer/ProgressBar
@onready var icon = $MarginContainer/HBoxContainer/VBoxContainer/Icon

func _process(delta):
	var new = _find_closest_craft_zone()
	if new != craft_zone:
		craft_zone = new
		_update()
	modulate.a = lerp(modulate.a, target_opacity, 0.05)
	if !craft_zone:
		target_opacity = 0
		return
	target_opacity = 1
	progress_bar.value = craft_zone.progress
	icon.texture = craft_zone.get_texture()
	
func _find_closest_craft_zone() -> CraftZoneData:
	var player_pos : Vector2 = get_tree().get_nodes_in_group("Player")[0].global_position
	var craft_zones = get_tree().get_nodes_in_group("CraftZone")
	var closest = null
	for zone in craft_zones:
		if !zone.get_data():
			continue
		var dist = player_pos.distance_to(zone.global_position)
		if dist > zone.get_data().craft_range:
			continue
		if !closest || dist < player_pos.distance_to(closest.global_position):
			closest = zone
	if closest == null:
		return null
	return closest.get_data()

func _update():
	if (!craft_zone):
		return
	craft_zone.ingredients_inv.on_update.connect(_update)
	craft_zone.fuel_inv.on_update.connect(_update)
	craft_zone.products_inv.on_update.connect(_update)
	update_slots()
	
func update_slots():
	for child in ingredients_slots.get_children():
		child.queue_free()
	for child in products_slots.get_children():
		child.queue_free()
	for child in fuel_slots.get_children():
		child.queue_free()

	for slot in craft_zone.ingredients_inv.slots:
		var instance : InventorySlot = slot_scene.instantiate()
		ingredients_slots.add_child(instance)
		instance.set_data(slot)
	for slot in craft_zone.products_inv.slots:
		var instance : InventorySlot = slot_scene.instantiate()
		products_slots.add_child(instance)
		instance.set_data(slot)
	for slot in craft_zone.fuel_inv.slots:
		var instance : InventorySlot = slot_scene.instantiate()
		fuel_slots.add_child(instance)
		instance.set_data(slot)


