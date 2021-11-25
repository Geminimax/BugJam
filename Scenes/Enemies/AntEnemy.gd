extends "res://Scenes/Enemies/Fly.gd"

var separation_distance = 10

func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if !player:
        return
    var vec_to_player = player.global_position - body.global_position
    vec_to_player = vec_to_player.normalized()
    
    var other_enemies = get_tree().get_nodes_in_group("enemy")
    var separation = Vector2()
    for enemy in other_enemies:
        if(body.global_position.distance_to(enemy.body.global_position) <= separation_distance):
            separation += (body.global_position - enemy.body.global_position).normalized()
    body.velocity = ((vec_to_player + separation ).normalized() *move_speed) 
