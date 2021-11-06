extends Node2D

var open = false setget set_open
var active = false setget set_active

func _ready():
	pass

func set_open(value):
	open = value
	if(open):
		$Area2D/CollisionShape2D.set_deferred("disabled", false)
		$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
	else:
		$Area2D/CollisionShape2D.set_deferred("disabled", true)
		$StaticBody2D/CollisionShape2D.set_deferred("disabled", false)

func set_active(value):
	active = value
	if(!active):
		$Area2D/CollisionShape2D.set_deferred("disabled", true)
		$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
		visible = false
