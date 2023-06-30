@tool
extends Spawner2D
@export var resource : Resource

func spawn():
	var instance = super()
	instance.set_resource(resource)
	return instance
