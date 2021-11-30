extends "res://Scenes/BaseController.gd"

export var move_speed = 80
export var experience = 500
var separation_distance = 10
onready var raycast = $RayCast2D
onready var hit_effect = $HitEffect

var bloodsplatter = load("res://Scenes/VFX/BloodSplatter.tscn")
var player = null

signal enemy_killed

func kill(area):
    emit_signal("enemy_killed", experience)
    splatter_blood(area)
    queue_free()

func splatter_blood(area):
    var inst = bloodsplatter.instance()
    get_parent().add_child(inst)
    inst.global_position = body.global_position
    inst.direction = -body.global_position.direction_to(area.global_position)
    inst.restart()
    
func set_player(p):
    player = p

func _on_Area2D_area_entered(area):
    if area.is_in_group("player_attack"):
        take_damage(area)
        if(health.current_health <= 0 ):
            kill(area)
    pass # Replace with function body.


func _on_KnockbackTimer_timeout():
    knockback_finished()

func take_damage(dmg_source):
    .take_damage(dmg_source)
    hit_effect.global_position = body.global_position
    hit_effect.frame = 0
    hit_effect.play()
