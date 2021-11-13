extends Camera2D

onready var move_tween = $Tween

func move(target):
    move_tween.interpolate_property(self, "position", global_position, target, 0.8, Tween.TRANS_CUBIC,Tween.EASE_OUT)
    move_tween.start()
