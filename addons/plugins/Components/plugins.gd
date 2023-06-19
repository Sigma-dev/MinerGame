@tool
extends EditorPlugin


func _enter_tree():
	# Initialization of the plugin goes here.
	# Add the new type with a name, a parent type, a script and an icon.
	add_custom_type("Health", "Node", preload("Health/Health.gd"), preload("Health/HealthIcon.png"))
	add_custom_type("FlashingSprite2D", "Sprite2D", preload("FlashingSprite2D/FlashingSprite2D.gd"), preload("FlashingSprite2D/FlashingSprite2DIcon.png"))
	add_custom_type("OnceParticles2D", "CPUParticles2D", preload("OnceParticles2D/OnceParticles2D.gd"), preload("OnceParticles2D/OnceParticles2DIcon.png"))

func _exit_tree():
	# Clean-up of the plugin goes here.
	# Always remember to remove it from the engine when deactivated.
	remove_custom_type("Health")
	remove_custom_type("FlashingSprite2D")
	remove_custom_type("OnceParticles2D")
