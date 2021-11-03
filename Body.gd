extends KinematicBody2D

var velocity = Vector2()

func _ready():
	pass # Replace with function body.


func _process(delta):
	move_and_slide(velocity)
