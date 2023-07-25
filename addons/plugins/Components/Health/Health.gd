@tool
extends Node
class_name Health

@export var maxHp = 100
@export var destroy_parent_on_death = true
var _hp

signal health_changed(hp, change)
signal damage_taken(damage, new_hp)
signal healing_received(healing, new_hp)
signal die()

# Called when the node enters the scene tree for the first time.
func _ready():
	_hp = maxHp
	pass # Replace with function body.

func damage(dmg, a = 0):
	health_changed.emit(_hp, -dmg)
	_hp -= dmg
	damage_taken.emit(dmg, _hp)
	if _hp <= 0:
		_on_death()
		
func heal(heal):
	health_changed.emit(_hp, heal)
	_hp += heal
	healing_received.emit(heal, _hp)

func _on_death():
	die.emit()
	if destroy_parent_on_death:
		get_parent().queue_free()
