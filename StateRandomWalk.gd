extends "res://Scenes/State/State.gd"

var rotate_range = 150

func update(delta):
    var player_dir = body.global_position.direction_to(controller.player.global_position)
    
    
    var other_enemies = get_tree().get_nodes_in_group("enemy")
    var separation = Vector2()
    for enemy in other_enemies:
        if(body.global_position.distance_to(enemy.body.global_position) <= controller.separation_distance):
            separation += (body.global_position - enemy.body.global_position).normalized()
    
    
    var new_vel = (player_dir + separation).normalized().rotated(deg2rad(rand_range(-rotate_range,rotate_range))) * controller.move_speed
    body.velocity = body.velocity.linear_interpolate(new_vel, delta * 2) 
    if(body.velocity.x < 0):
        controller.sprite.flip_h = true
    else:
        controller.sprite.flip_h = false
