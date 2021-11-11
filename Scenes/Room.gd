extends Node2D

signal room_exited

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_neighbors(north, south, west, east):
	$Doors/North.active = true if north else false
	$Doors/South.active = true if south else false
	$Doors/West.active = true if west else false
	$Doors/East.active = true if east else false
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_North_door_entered():
	emit_signal("room_exited", Vector2.UP)


func _on_South_door_entered():
	emit_signal("room_exited", Vector2.DOWN)


func _on_West_door_entered():
	emit_signal("room_exited", Vector2.LEFT)


func _on_East_door_entered():
	emit_signal("room_exited", Vector2.RIGHT)
