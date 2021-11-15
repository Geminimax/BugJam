extends Node2D

var level_size = 8
#var direction_change_chance 
var room_count = 16
var current_room_count = 0
var rooms = []
var level_matrix = []
var room_instances = {}

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

func instantiate_rooms(room_size, room_separation, object, method):
    for room in rooms:
        var room_layout = room_layouts[randi()%room_layouts.size()]
        var room_inst = room_layout.instance()
        room_instances[room] = room_inst
        object.add_child(room_inst)
        room_inst.global_position = room * (room_size + room_separation)
        directions = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]
        var neighbors = []
        for dir in directions:
            if is_valid(room + dir, level_size) and level_matrix[(room + dir).x][(room + dir).y] == 1:
                neighbors.append(true)
            else:
                neighbors.append(false)
        room_inst.set_neighbors(neighbors[0], neighbors[1], neighbors[2], neighbors[3])
        room_inst.connect('room_exited', object, method)

func instantiate_enemies(room, level_manager, player):
    var room_inst = get_room_inst(room)
    if room_inst.clear:
        return
    var enemy_positions = room_inst.enemy_positions
    var enemy_types = room_inst.enemy_types
    
    for pos in enemy_positions:
        var new_enemy = enemy_types[randi() % enemy_types.size()].instance()
        level_manager.add_child(new_enemy)
        new_enemy.global_position = pos.global_position
        new_enemy.player = player.body
        new_enemy.connect("enemy_killed", player, "on_enemy_killed")
    room_inst.clear = true

func is_valid(vector, matrix_size):
    return (vector.x < matrix_size and vector.x >= 0 and vector.y < matrix_size and vector.y >= 0)
    
func get_room_inst(room):
    return room_instances[room]
