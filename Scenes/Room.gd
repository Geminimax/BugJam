extends Node2D

signal room_exited
const TILE_SIZE = 16

export (Array,int) var floor_tiles = [1]
var room_size = Vector2(640,368)

onready var tilemap = $TileMap
func _ready():
    draw_floor()
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

func draw_floor():
    for i in range(room_size.x / TILE_SIZE):
        for j in range(room_size.y / TILE_SIZE):
            var pos = Vector2(i,j)
            if(tilemap.get_cellv(pos) == TileMap.INVALID_CELL):
                tilemap.set_cellv(pos, floor_tiles[randi()%floor_tiles.size()])
