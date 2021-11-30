extends Node

onready var hitpause_timer = $HitpauseTimer

var camera 
func hitpause(time):
    if(get_tree().paused):
        return
    get_tree().paused = true
    hitpause_timer.start(time)
    yield(hitpause_timer,"timeout")
    get_tree().paused = false

func screen_shake(time,intensity):
    camera.start_shake(time,intensity)

func zoom(amount,time_in,time_out,delay = 0):
    camera.zoom(amount,time_in,time_out,delay)
