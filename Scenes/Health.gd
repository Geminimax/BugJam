extends Node2D

var max_health
var current_health

signal health_changed

func _ready():
    current_health = max_health

func take_damage(amount):
    if amount < 0:
        return
    current_health = max(current_health-amount, 0)
    emit_signal("health_changed", current_health)

func heal(amount):
    if amount < 0:
        return
    current_health = min(current_health+amount, max_health)
    emit_signal("health_changed", current_health)
