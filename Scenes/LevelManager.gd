extends Node2D

var player_inst
var current_room

var room_size = Vector2(640, 368)
var room_separation = Vector2(32,32)
const PositionOffset = {CENTER = Vector2(320, 180), NORTH = Vector2(0, 60), SOUTH = Vector2(0, -60), WEST = Vector2(60, 0), EAST = Vector2(-60, 0)}

onready var level_generator = $LevelGenerator
onready var camera = $Camera

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

func set_player_position(room, pos=null):
    var room_inst = level_generator.get_room_inst(room)
    var door_position
    match pos:
        Vector2.UP:
            door_position = room_inst.get_node("Doors/North").global_position
            player_inst.body.global_position = door_position + PositionOffset.NORTH
        Vector2.DOWN:
            door_position = room_inst.get_node("Doors/South").global_position
            player_inst.body.global_position = door_position + PositionOffset.SOUTH
        Vector2.LEFT:
            door_position = room_inst.get_node("Doors/West").global_position
            player_inst.body.global_position = door_position + PositionOffset.WEST
        Vector2.RIGHT:
            door_position = room_inst.get_node("Doors/East").global_position
            player_inst.body.global_position = door_position + PositionOffset.EAST
        _:
            player_inst.body.global_position = get_room_position(room) + PositionOffset.CENTER

func get_room_position(room):
    return room * (room_size + room_separation)

func on_room_exit(dir):
    current_room += dir
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
