extends Node2D

var level_size = 8
#var direction_change_chance 
var room_count = 16
var current_room_count = 0
var rooms = []
var level_matrix = []

var directions = [Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN]

export (Array, PackedScene) var room_layouts

func generate():
	#Initialization
	for i in range(level_size):
		var row = []
		for j in range(level_size):
			row.append(0)
		level_matrix.append(row)
	
	var current_position = Vector2(randi()%level_size, randi()%level_size)
	var position_stack = [current_position]
	
	# DFS
	while(current_room_count < room_count):
		while(rooms.has(current_position)):
			current_position = position_stack.pop_back()
		level_matrix[current_position.x][current_position.y] = 1
		rooms.append(current_position)
		current_room_count += 1
		
		directions.shuffle()
		for dir in directions:
			if(is_valid(current_position + dir, level_size)):
				position_stack.append(current_position + dir)

func instantiate_rooms(room_size, object, method):
	for room in rooms:
		var room_layout = room_layouts[randi()%room_layouts.size()]
		var room_inst = room_layout.instance()
		object.add_child(room_inst)
		room_inst.global_position = Vector2(room.x * room_size.x, room.y * room_size.y)
		directions = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]
		var neighbors = []
		for dir in directions:
			if is_valid(room + dir, level_size) and level_matrix[(room + dir).x][(room + dir).y] == 1:
				neighbors.append(true)
			else:
				neighbors.append(false)
		room_inst.set_neighbors(neighbors[0], neighbors[1], neighbors[2], neighbors[3])
		room_inst.connect('room_exited', object, method)

func is_valid(vector, matrix_size):
	return (vector.x < matrix_size and vector.x >= 0 and vector.y < matrix_size and vector.y >= 0)
