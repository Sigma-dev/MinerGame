extends Button

@onready var label : Label = $Label
@onready var texture = $MarginContainer/TextureRect
var slot_data : SlotData = null
signal on_slot_selected(slot)
# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(func(): on_slot_selected.emit(slot_data))

func set_data(new_slot_data: SlotData):
	slot_data = new_slot_data
	texture.texture = slot_data.item_data.texture
	label.text =  "x" + str(slot_data.quantity)
	label.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

