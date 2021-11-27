extends "res://Scenes/State/State.gd"

func update(delta):
    controller.sprite.play("knockback")
    body.velocity = body.velocity.linear_interpolate(Vector2.ZERO,delta * 3)
    
func state_enter():
    controller.animation_player.play("flash")

func state_exit():
    controller.animation_player.seek(0,true)
    controller.animation_player.stop(true)
