extends Node2D

export var move_speed = 80

var level = 1
var experience = 0
var exp_per_level = 1000

onready var raycast = $Body/RayCast2D
onready var body = $Body
onready var gun = $Body/Gun
onready var sprite = $Body/AnimatedSprite
var cooldown = 0.5
var current_cooldown = 0
var knockback_strength = 200 

func _ready():
    yield(get_tree(), "idle_frame")
    get_tree().call_group("enemies","set_player",self.body)
    
func _physics_process(delta):
    var move_vec = Vector2()
    
    if Input.is_action_pressed("move_up"):
        move_vec.y -=1
    if Input.is_action_pressed("move_down"):
        move_vec.y +=1
    if Input.is_action_pressed("move_left"):
        move_vec.x -=1
    if Input.is_action_pressed("move_right"):
        move_vec.x +=1
    move_vec = move_vec.normalized()
    body.velocity = body.velocity.linear_interpolate(move_vec * move_speed, delta * 10)
    
    if(move_vec != Vector2.ZERO):
        sprite.play("walk")
    else:
        sprite.play("idle")
    var look_vec = get_global_mouse_position() - body.global_position
    #body.global_rotation = atan2(look_vec.y, look_vec.x)
    
    if Input.is_action_pressed("shoot"):
        if current_cooldown <= 0:
            gun.fire(look_vec.normalized())
            current_cooldown = cooldown
    current_cooldown -= delta

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
    if(area.is_in_group("enemy_damage_area")):
        on_hit(area)
    
func on_hit(source):
    body.velocity = -(source.global_position - body.global_position).normalized() * knockback_strength
