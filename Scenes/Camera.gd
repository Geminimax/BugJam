extends Camera2D

onready var move_tween = $Tween

func move(target):
    move_tween.interpolate_property(self, "position", global_position, target, 0.8, Tween.TRANS_CUBIC,Tween.EASE_OUT)
    move_tween.start()


var shaking = false
var shake_time 
var shake_str
var follow
onready var tween = $Tween
# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func start_shake(time,strength):
    shake_time = time 
    shake_str = strength * 15
    shaking = true

func stop_shake():
    shaking = false
    offset.x = 0
    offset.y = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if(follow):
        global_position = follow.global_position
    if(shaking):
        shake_time -= delta
        shake()
        if(shake_time <= 0):
            stop_shake()
    else:
        offset.x = 0
        offset.y = 0
        
func shake():
    offset.x =  lerp(offset.x,rand_range(-shake_str,shake_str),0.05)
    offset.y = lerp(offset.y,rand_range(-shake_str,shake_str),0.05)

func zoom(amount,time_in,time_out,delay = 0):
    tween.interpolate_property(self,"zoom:x",1.0,amount,time_in,Tween.TRANS_QUAD,Tween.EASE_OUT)
    tween.interpolate_property(self,"zoom:y",1.0,amount,time_in,Tween.TRANS_QUAD,Tween.EASE_OUT)
    tween.interpolate_property(self,"zoom:x",amount,1.0,time_out,Tween.TRANS_QUAD,Tween.EASE_OUT,time_in + delay)
    tween.interpolate_property(self,"zoom:y",amount,1.0,time_out,Tween.TRANS_QUAD,Tween.EASE_OUT,time_in + delay)
    tween.start()
