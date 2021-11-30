extends Node2D

signal bullet_hit(enemy)
signal bullet_shot

export (int) var projectile_amount = 1
export (int) var projectile_speed_modifier = 1
export (int) var projectile_damage_modifier = 1

export (PackedScene) var bullet

func fire(direction, spawn_position = global_position):
    var bullet_instance = bullet.instance()
    bullet_instance.direction = direction
    bullet_instance.global_position = spawn_position
    get_tree().root.add_child(bullet_instance)
    bullet_instance.connect("bullet_hit", self, "on_bullet_hit")
    emit_signal("bullet_shot")
func on_bullet_hit(enemy):
    emit_signal("bullet_hit",enemy)
