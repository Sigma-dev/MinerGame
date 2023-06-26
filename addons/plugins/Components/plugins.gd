@tool
extends EditorPlugin


func _enter_tree():
	# Initialization of the plugin goes here.
	# Add the new type with a name, a parent type, a script and an icon.
	add_custom_type("Health", "Node", preload("Health/Health.gd"), preload("Health/HealthIcon.png"))
	add_custom_type("FlashingSprite2D", "Sprite2D", preload("FlashingSprite2D/FlashingSprite2D.gd"), preload("FlashingSprite2D/FlashingSprite2DIcon.png"))
	add_custom_type("OnceParticles2D", "CPUParticles2D", preload("OnceParticles2D/OnceParticles2D.gd"), preload("OnceParticles2D/OnceParticles2DIcon.png"))
	add_custom_type("Spawner2D", "Node2D", preload("Spawner2D/Spawner2D.gd"), preload("Spawner2D/Spawner2DIcon.png"))
	add_custom_type("ResourceSpawner2D", "Node2D", preload("ResourceSpawner2D/ResourceSpawner2D.gd"), preload("ResourceSpawner2D/ResourceSpawner2DIcon.png"))
	add_custom_type("Hittable", "Node", preload("Hittable/Hittable.gd"), preload("Hittable/HittableIcon.png"))
	add_custom_type("HitOnContact2D", "Node2D", preload("HitOnContact2D/HitOnContact2D.gd"), preload("HitOnContact2D/HitOnContact2DIcon.png"))

func _exit_tree():
	# Clean-up of the plugin goes here.
	# Always remember to remove it from the engine when deactivated.
	remove_custom_type("Health")
	remove_custom_type("FlashingSprite2D")
	remove_custom_type("OnceParticles2D")
	remove_custom_type("Spawner2D")
	remove_custom_type("ResourceSpawner2D")
	remove_custom_type("Hittable")
	remove_custom_type("HitOnContact2D")
