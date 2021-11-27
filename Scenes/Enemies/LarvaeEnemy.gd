extends "res://Scenes/Enemies/BaseEnemy.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    state_machine.change_state("StateRandomWalk")
