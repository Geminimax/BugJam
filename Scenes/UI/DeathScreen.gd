extends Control

onready var tween = $Tween

func reveal():
    visible = true
    tween.interpolate_property(self,"modulate:a",0,1.0,1.0,Tween.TRANS_CUBIC,Tween.EASE_OUT)
    tween.start()


func _on_Restart_button_down():
    get_tree().paused = false
    get_tree().reload_current_scene()
