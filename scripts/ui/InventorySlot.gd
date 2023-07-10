extends Button

@onready var label : Label = $Label
@onready var texture = $MarginContainer/TextureRect

var slot_data : SlotData = null
signal on_slot_selected(slot, index)

func _ready():
	pressed.connect(func(): on_slot_selected.emit())

func set_data(new_slot_data: SlotData):
	slot_data = new_slot_data
	texture.texture = slot_data.item_data.texture
	label.text =  "x" + str(slot_data.quantity)
	label.visible = true

func _process(delta):
	pass

