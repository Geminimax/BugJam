extends KinematicBody2D

export var move_speed = 150
export var experience = 500

onready var raycast = $RayCast2D

var player = null

signal enemy_killed

func _ready():
    add_to_group("enemies")

func _physics_process(delta):
    if player == null:
        return
    var vec_to_player = player.global_position - global_position
    vec_to_player = vec_to_player.normalized()
    global_rotation = atan2(vec_to_player.y,vec_to_player.x)
    move_and_collide(vec_to_player*move_speed*delta)
    
    if raycast.is_colliding():
        var collide = raycast.get_collider()
        if collide.name == "Player":
            collide.kill()

func kill():
    emit_signal("enemy_killed", experience)
    queue_free()
    
func set_player(p):
    player = p


func _on_Area2D_area_entered(area):
    kill()
    pass # Replace with function body.
