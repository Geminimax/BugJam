extends Node

onready var hitpause_timer = $HitpauseTimer

var camera 
func hitpause(time):
    get_tree().paused = true
    hitpause_timer.start(time)
    yield(hitpause_timer,"timeout")
    get_tree().paused = false

func screen_shake(time,intensity):
    pass
