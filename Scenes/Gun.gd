extends Node2D


export (PackedScene) var bullet

func fire(direction, spawn_position = global_position):
	var bullet_instance = bullet.instance()
	bullet_instance.direction = direction
	bullet_instance.global_position = spawn_position
	get_tree().root.add_child(bullet_instance)
	
