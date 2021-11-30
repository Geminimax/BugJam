extends Control


func update_bar(current_value,max_value):
    $HBoxContainer/TextureProgress.max_value = max_value
    $HBoxContainer/TextureProgress.value = current_value
