extends "res://Scenes/State/State.gd"


func state_enter():
    body.velocity = Vector2.ZERO
    controller.sprite.play("death")
