extends "res://Scenes/Enemies/BaseEnemy.gd"

func _ready():
    state_machine.change_state("StateEnemyPorsue")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    ._process(delta)

func knockback_finished():
    state_machine.change_state("StateEnemyPorsue")
    
