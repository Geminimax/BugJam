extends Node2D

signal bullet_hit(target)
signal projectile_destroyed
var direction
export (float) var speed = 400
export (bool) var destroy_on_animation_finished =  false
export (bool) var player_projectile = false
export (int) var damage_amount = 1
export (bool) var destroy_on_hit = true
export (float) var knockback_str = 1 

onready var col_area = $Area2D
onready var sprite = $AnimatedSprite
# Called when the node enters the scene tree for the first time.
func _ready():
    col_area.damage_amount = damage_amount
    if(player_projectile):
        col_area.add_to_group("player_attack")
    else:
        col_area.add_to_group("enemy_damage_area")
    sprite.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    $AnimatedSprite.rotation = direction.angle()
    global_position += direction * speed * delta

func destroy():
    emit_signal("projectile_destroyed")
    queue_free()
    
func _on_Area2D_area_entered(area):
    emit_signal("bullet_hit", area)
    if(destroy_on_hit):
        destroy()


func _on_Area2D_body_entered(body):
    if(destroy_on_hit):
        destroy()

func _on_AnimatedSprite_animation_finished():
    if(destroy_on_animation_finished):
        destroy()
