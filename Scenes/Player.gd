extends "res://Scenes/BaseController.gd"

signal level_up
export var move_speed = 80

var level = 1
var experience = 0
var exp_per_level = 1000
var invincible = false
onready var raycast = $Body/RayCast2D
onready var gun = $Body/Gun
onready var invencibiltiy_timer = $Invencibility
onready var health_bar = $CanvasLayer/HealthBarUI
onready var exp_bar = $CanvasLayer/ExpBarUI
onready var death_screen = $CanvasLayer/DeathScreen
onready var level_up_anim = $Body/LevelUpAnim
var cooldown = 0.5
var current_cooldown = 0

func _ready():
    state_machine.change_state("StatePlayerBase")
    health_bar.update_bar(health.current_health,health.max_health)
    exp_bar.update_bar(experience,exp_per_level)
func _process(delta):
    current_cooldown -= delta
    
func shoot(dir):
    if current_cooldown <= 0:
        gun.fire(dir)
        current_cooldown = cooldown

func kill():
    get_tree().reload_current_scene()
    
func level_up():
    emit_signal("level_up")
    level += 1
    level_up_anim.frame = 0
    level_up_anim.play()
func gain_exp(amount):
    experience += amount
    if experience >= exp_per_level:
        experience -= exp_per_level
        level_up()
    
    exp_bar.update_bar(experience,exp_per_level)
func on_enemy_killed(exp_amount):
    gain_exp(exp_amount)
    EffectsManager.zoom(0.98,0.1,0.2)

func _on_Area2D_area_entered(area):
    if(area.is_in_group("enemy_damage_area") and !invincible):
        invincible = true
        invencibiltiy_timer.start()
        take_damage(area)
        health_bar.update_bar(health.current_health,health.max_health)
        EffectsManager.hitpause(0.1)
        EffectsManager.screen_shake(0.5,1.0)

func _on_Gun_bullet_hit(enemy):
    EffectsManager.hitpause(0.06)
    EffectsManager.screen_shake(0.2,0.3)


func _on_KnockbackTimer_timeout():
    knockback_finished()

func knockback_finished():
    state_machine.change_state("StatePlayerBase")


func _on_Invencibility_timeout():
    invincible = false


func _on_Health_health_changed(health, delta):
    if(health <= 0):
        die()

func die():
    invincible = true
    $Invencibility.stop()
    state_machine.change_state("StatePlayerDeath")
    EffectsManager.zoom(0.95,0.1,0.6)
    EffectsManager.screen_shake(1.0,1.0)
    yield(get_tree().create_timer(1.0),"timeout")
    get_tree().paused = true
    death_screen.reveal()    
