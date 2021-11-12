extends Node2D

var player_inst
var current_room

var room_size = Vector2(640, 360)
const PositionOffset = {CENTER = Vector2(320, 180), NORTH = Vector2(320, 60), SOUTH = Vector2(320, 300), WEST = Vector2(60, 180), EAST = Vector2(580, 180)}

onready var level_generator = $LevelGenerator
onready var camera = $Camera2D

var player_scene = load("res://Scenes/Player.tscn")

func _ready():
	randomize()
	$LevelGenerator.generate()
	$LevelGenerator.instantiate_rooms(room_size, self, 'on_room_exit')
	current_room = level_generator.rooms[0]
	instantiate_player()
	set_camera_position(current_room)

func instantiate_player():
	player_inst = player_scene.instance()
	add_child(player_inst)
	set_player_position(current_room, PositionOffset.CENTER)

func set_player_position(room, offset):
	player_inst.body.global_position = Vector2(current_room.x * room_size.x, current_room.y * room_size.y) + offset
	print(room, offset)
	
func set_camera_position(room):
	camera.global_position = Vector2(room.x * room_size.x, room.y * room_size.y) + PositionOffset.CENTER
	
func on_room_exit(dir):
	current_room += dir
	set_camera_position(current_room)
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
	
	
	
