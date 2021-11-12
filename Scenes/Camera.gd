extends Camera2D

onready var move_tween = $Tween

func move(target):
	move_tween.interpolate_property(self, "position", global_position, target, 0.5, Tween.TRANS_CUBIC,Tween.EASE_IN_OUT)
	move_tween.start()
