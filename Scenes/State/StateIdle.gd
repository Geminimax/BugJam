extends "res://Scenes/State/State.gd"


func update(delta):
    controller.sprite.play("idle")
    body.velocity = body.velocity.linear_interpolate(Vector2.ZERO, delta * 5)
