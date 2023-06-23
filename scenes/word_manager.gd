extends Node2D

var player = null

func _ready():
	player = get_tree().get_nodes_in_group("Player")[0]
