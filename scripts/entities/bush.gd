extends StaticBody2D

#@onready var health : Health = $Health
var dropped_berries = false
@onready var berry_spawner : Spawner2D = $BerrySpawner
@onready var flashing_sprite_2d = $FlashingSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
#	health.damage_taken.connect(func(a, b): try_drop())
	pass # Replace with function body.

func try_drop():
	if dropped_berries:
		return
	dropped_berries = true
	berry_spawner.spawn()
	flashing_sprite_2d.frame = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
