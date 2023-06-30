extends PanelContainer

@onready var label : Label = $Label
@onready var texture = $MarginContainer/TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_data(data: SlotData):
	texture.texture = data.item_data.texture
	label.text =  "x" + str(data.quantity)
	label.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
