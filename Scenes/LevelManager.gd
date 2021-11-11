extends Node2D

var player_inst
var player_position
var player_offset = Vector2(320, 180)

var room_size = Vector2(640, 360)

var player_scene = load("res://Scenes/Player.tscn")

onready var level_generator = $LevelGenerator
onready var camera = $Camera2D

func _ready():
	randomize()
	$LevelGenerator.generate()
	$LevelGenerator.instantiate_rooms(room_size, self, 'on_room_exit')
	instantiate_player()
	set_camera_position(level_generator.rooms[0])

func instantiate_player():
	player_inst = player_scene.instance()
	add_child(player_inst)
	set_player_position(level_generator.rooms[0])

func set_player_position(room):
	player_position = room
	player_inst.body.global_position = Vector2(player_position.x * room_size.x, player_position.y * room_size.y) + player_offset
	
func set_camera_position(room):
	camera.global_position = Vector2(room.x * room_size.x, room.y * room_size.y) + player_offset
	
func on_room_exit(dir):
	print(player_position)
	set_player_position(player_position+dir)
	print(player_position)
	set_camera_position(player_position)
	
	
	
