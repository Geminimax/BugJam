extends "res://Scenes/BaseController.gd"

export var move_speed = 80

var level = 1
var experience = 0
var exp_per_level = 1000
var invincible = false
onready var raycast = $Body/RayCast2D
onready var gun = $Body/Gun
onready var invencibiltiy_timer = $Invencibility

var cooldown = 0.5
var current_cooldown = 0

func _ready():
    state_machine.change_state("StatePlayerBase")
    
func _process(delta):
    current_cooldown -= delta
    
func shoot(dir):
    if current_cooldown <= 0:
        gun.fire(dir)
        current_cooldown = cooldown

func kill():
    get_tree().reload_current_scene()
    
func level_up():
    print("Level up")
    level += 1
    
func gain_exp(amount):
    experience += amount
    if experience >= exp_per_level:
        experience -= exp_per_level
        level_up()

func on_enemy_killed(exp_amount):
    gain_exp(exp_amount)

func _on_Area2D_area_entered(area):
    if(area.is_in_group("enemy_damage_area") and !invincible):
        invincible = true
        invencibiltiy_timer.start()
        take_damage(area)
        EffectsManager.hitpause(0.1)

func _on_Gun_bullet_hit(enemy):
    EffectsManager.hitpause(0.06)
    EffectsManager.screen_shake(0.2,0.2)


func _on_KnockbackTimer_timeout():
    knockback_finished()

func knockback_finished():
    state_machine.change_state("StatePlayerBase")


func _on_Invencibility_timeout():
    invincible = false
