extends Node2D

export var move_speed = 80
export var experience = 500

onready var raycast = $RayCast2D
onready var body = $Body
onready var health = $Health

var player = null

signal enemy_killed

func _ready():
    add_to_group("enemies")

func _physics_process(delta):
    if player == null:
        return
    

func kill():
    emit_signal("enemy_killed", experience)
    queue_free()
    
func set_player(p):
    player = p


func _on_Area2D_area_entered(area):
    if area.is_in_group("player_attack"):
        health.take_damage(area.damage_amount)
    pass # Replace with function body.


func _on_Health_health_changed(health,delta):
    print("health changed")
    if(health == 0):
        kill()
