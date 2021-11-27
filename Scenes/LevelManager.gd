extends Node2D

var player_inst
var current_room

var room_size = Vector2(360, 240)
var room_separation = Vector2(32,32)
var dir_offset = 30
const PositionOffset = {CENTER = Vector2(180, 120), NORTH = Vector2(0, 60), SOUTH = Vector2(0, -60), WEST = Vector2(60, 0), EAST = Vector2(-60, 0)}

onready var level_generator = $LevelGenerator
onready var camera = $Camera
var current_room_enemy_count = 0

var player_scene = load("res://Scenes/Player.tscn")

func _ready():
    randomize()
    level_generator.generate()
    level_generator.instantiate_rooms(room_size, room_separation, self, 'on_room_exit')
    current_room = level_generator.rooms[0]
    instantiate_player()
    camera.global_position = get_room_position(current_room) + PositionOffset.CENTER

func instantiate_player():
    player_inst = player_scene.instance()
    add_child(player_inst)
    set_player_position(current_room)
    finish_room()

func finish_room():
    level_generator.get_room_inst(current_room).open_doors()
    level_generator.get_room_inst(current_room).clear = true
func set_player_position(room, pos=null):
    var room_inst = level_generator.get_room_inst(room)
    var door_position
    
    match pos:
        Vector2.UP:
            door_position = room_inst.north_door.global_position
            player_inst.body.global_position = door_position + dir_offset * -pos
        Vector2.DOWN:
            door_position = room_inst.south_door.global_position
            player_inst.body.global_position = door_position + dir_offset * -pos
        Vector2.LEFT:
            door_position = room_inst.west_door.global_position
            player_inst.body.global_position = door_position + dir_offset * -pos
        Vector2.RIGHT:
            door_position = room_inst.east_door.global_position
            player_inst.body.global_position = door_position + dir_offset * -pos
        _:
            player_inst.body.global_position = get_room_position(room) + PositionOffset.CENTER

func get_room_position(room):
    return room * (room_size + room_separation)

func on_room_exit(dir):
    current_room += dir
    level_generator.instantiate_enemies(current_room, self, player_inst)
    camera.move(get_room_position(current_room) + PositionOffset.CENTER)
    match dir:
        Vector2.UP:
            set_player_position(current_room, Vector2.DOWN)
        Vector2.DOWN:
            set_player_position(current_room, Vector2.UP)
        Vector2.LEFT:
            set_player_position(current_room, Vector2.RIGHT)
        Vector2.RIGHT:
            set_player_position(current_room, Vector2.LEFT)
        _:
            set_player_position(current_room)


func _on_LevelGenerator_enemy_spawn(enemy):
    current_room_enemy_count += 1
    
    enemy.connect("enemy_killed", self, "on_enemy_killed")

func on_enemy_killed(enemy):
    print("enemy_killed")
    current_room_enemy_count -= 1
    if(current_room_enemy_count <= 0):
        finish_room()
