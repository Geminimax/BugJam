extends Node2D

onready var state_machine = $StateMachine
onready var body = $Body
onready var health = $Health
onready var sprite = $Body/AnimatedSprite
onready var animation_player = $AnimationPlayer

var base_knockback_str = 300
onready var knockback_timer = $KnockbackTimer

func _ready():
    sprite.material = sprite.material.duplicate()
    state_machine.controller = self
    state_machine.body = body
    
    for state in state_machine.get_children():
        state_machine.add_state(state.name, state)

func _process(delta):
    state_machine.update(delta)

func take_damage(dmg_source):
    health.take_damage(dmg_source.damage_amount)
    if(health.current_health > 0):
        knockback(dmg_source)

func knockback(dmg_source):
    body.velocity = -(dmg_source.global_position - body.global_position ).normalized() * base_knockback_str
    state_machine.change_state("StateKnockback")
    knockback_timer.start()

func knockback_finished():
    pass
