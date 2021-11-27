extends "res://Scenes/Enemies/BaseEnemy.gd"

var wait_time_range = Vector2(1.6,2.5)

func _ready():
    state_machine.change_state("StateIdle")
    $IdleTimer.start(rand_range(wait_time_range.x,wait_time_range.y))

func _process(delta):
    if(state_machine.current_state == "StateDash"):
        var state = state_machine.get_current_state()
        if(body.velocity.length() > 135):
            state_machine.change_state("StateIdle")
            $IdleTimer.start(rand_range(wait_time_range.x,wait_time_range.y))

func _on_IdleTimer_timeout():
   state_machine.change_state("StateDash")

func knockback_finished():
    state_machine.change_state("StateIdle")
    $IdleTimer.start(rand_range(wait_time_range.x,wait_time_range.y))
