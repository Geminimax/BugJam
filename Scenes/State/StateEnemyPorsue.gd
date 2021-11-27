extends "res://Scenes/State/State.gd"

func update(delta):
    var player = controller.player
    if !player:
        return
    var vec_to_player = player.global_position - body.global_position
    vec_to_player = vec_to_player.normalized()
    controller.sprite.play("porsue")
    var other_enemies = get_tree().get_nodes_in_group("enemy")
    var separation = Vector2()
    for enemy in other_enemies:
        if(body.global_position.distance_to(enemy.body.global_position) <= controller.separation_distance):
            separation += (body.global_position - enemy.body.global_position).normalized()
    body.velocity = ((vec_to_player + separation ).normalized() * controller.move_speed) 
