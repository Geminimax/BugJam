extends Node2D

var level_size = 8
#var direction_change_chance 
var room_count = 16
var current_room_count = 0
var rooms = []
var level_matrix = []
var room_size = 64

var directions = [Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN]
var room_scene = load("res://Scenes/Room.tscn")
#export (PackedScene) var room
func _ready():
	randomize()
	generate()
	instantiate_rooms()
func generate():
	#Initialization
	for i in range(level_size):
		var row = []
		for j in range(level_size):
			row.append(0)
		level_matrix.append(row)
	
	var current_position = Vector2(randi()%level_size, randi()%level_size)
	var position_stack = []
	print(current_position)
	while(current_room_count < room_count):
		current_room_count += 1
		directions.shuffle()
		rooms.append(current_position)
		for dir in directions:
			if(is_valid(current_position + dir, level_matrix)):
				position_stack.append(current_position + dir)
		level_matrix[current_position.x][current_position.y] = 1
		while(level_matrix[current_position.x][current_position.y] == 1):
			current_position = position_stack.pop_back()
		print(current_position)
			
	print(level_matrix)
			

func instantiate_rooms():
	for room in rooms:
		var room_inst = room_scene.instance()
		add_child(room_inst)
		room_inst.global_position = Vector2(room.x * room_size, room.y * room_size)

func is_valid(vector, matrix):
	return (vector.x < matrix.size() and vector.x >= 0 and vector.y < matrix[0].size() and vector.y >= 0 and matrix[vector.x][vector.y] != 1)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
