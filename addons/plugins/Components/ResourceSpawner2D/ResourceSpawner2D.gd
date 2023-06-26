@tool
extends Spawner2D
@export var resource : Resource

func spawn(a = 0, b = 0, c = 0, d = 0, e = 0, f = 0):
	var instance = super()
	instance.set_resource(resource)
	return instance
