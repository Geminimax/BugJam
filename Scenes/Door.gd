extends Node2D

var open = false setget set_open
var active = false setget set_active

signal door_entered

func _ready():
    set_active(false)

func set_open(value):
    open = value
    if(open):
        $Area2D/CollisionShape2D.set_deferred("disabled", false)
        $StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
        $Sprite.play("open")
    else:
        $Area2D/CollisionShape2D.set_deferred("disabled", true)
        $StaticBody2D/CollisionShape2D.set_deferred("disabled", false)

func set_active(value):
    active = value
    if(!active):
        $Area2D/CollisionShape2D.set_deferred("disabled", true)
        $StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
        visible = false
    else:
        $Area2D/CollisionShape2D.set_deferred("disabled", !open)
        $StaticBody2D/CollisionShape2D.set_deferred("disabled", open)
        visible = true


func _on_Area2D_area_entered(area):
    emit_signal("door_entered")
