extends PanelContainer

var slot_scene : PackedScene = preload("res://scenes/ui/slot.tscn")
@export var inventory_data: InventoryData = null
@onready var slots = $MarginContainer/Slots

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
		if slot_data:
			instance.set_data(slot_data)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
