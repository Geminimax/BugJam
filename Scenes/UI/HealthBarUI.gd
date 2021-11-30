extends Control

const BASE_SIZE_X = 16
const BASE_SIZE_Y = 16
func _ready():
    update_bar(5,10)

func update_bar(current_health,max_health):
    $Frame.rect_size.x = BASE_SIZE_X * max_health
    $Empty.rect_size.x = BASE_SIZE_X * max_health
    $Full.rect_size.x = BASE_SIZE_X * current_health
    if(current_health == 0):
        $Full.visible = false
    else:
        $Full.visible = true
