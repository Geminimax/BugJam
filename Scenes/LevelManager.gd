extends Node2D

var player_inst
var current_room

var room_size = Vector2(640, 360)
const PositionOffset = {CENTER = Vector2(320, 180), NORTH = Vector2(320, 40), SOUTH = Vector2(320, 320), WEST = Vector2(40, 180), EAST = Vector2(600, 180)}

onready var level_generator = $LevelGenerator
onready var camera = $Camera

var player_scene = load("res://Scenes/Player.tscn")

func _ready():
	randomize()
	level_generator.generate()
	level_generator.instantiate_rooms(room_size, self, 'on_room_exit')
	current_room = level_generator.rooms[0]
	instantiate_player()
	camera.global_position = get_room_position(current_room) + PositionOffset.CENTER

func instantiate_player():
	player_inst = player_scene.instance()
	add_child(player_inst)
	set_player_position(current_room, PositionOffset.CENTER)

func set_player_position(room, offset):
	player_inst.body.global_position = get_room_position(room) + offset

func get_room_position(room):
	return Vector2(room.x * room_size.x, room.y * room_size.y)

func on_room_exit(dir):
	current_room += dir
	camera.move(get_room_position(current_room) + PositionOffset.CENTER)
	match dir:
		Vector2.UP:
			set_player_position(current_room, PositionOffset.SOUTH)
		Vector2.DOWN:
			set_player_position(current_room, PositionOffset.NORTH)
		Vector2.LEFT:
			set_player_position(current_room, PositionOffset.EAST)
		Vector2.RIGHT:
			set_player_position(current_room, PositionOffset.WEST)
		_:
			set_player_position(current_room, PositionOffset.CENTER)
