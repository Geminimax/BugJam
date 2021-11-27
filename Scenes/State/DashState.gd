extends "res://Scenes/State/State.gd"

var target_pos
var target_offset_range = 25
var target_direction 
var accel = 100
var initial_speed = 30
func update(delta):
    controller.sprite.play("dash")
    body.velocity += accel * target_direction * delta
func state_enter():
    target_pos = controller.player.global_position
    target_direction = body.global_position.direction_to(target_pos).rotated(deg2rad(rand_range(-target_offset_range,target_offset_range)))
    body.velocity = initial_speed * target_direction

func state_exit():
    pass
