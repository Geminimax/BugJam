extends Node2D


const MOVE_SPEED = 300

onready var raycast = $Body/RayCast2D
onready var body = $Body
onready var gun = $Body/Gun
 
func _ready():
	yield(get_tree(), "idle_frame")
	get_tree().call_group("enemies","set_player",self.body)
	
func _physics_process(delta):
	var move_vec = Vector2()
	
	if Input.is_action_pressed("move_up"):
		move_vec.y -=1
	if Input.is_action_pressed("move_down"):
		move_vec.y +=1
	if Input.is_action_pressed("move_left"):
		move_vec.x -=1
	if Input.is_action_pressed("move_right"):
		move_vec.x +=1
	move_vec = move_vec.normalized()
	body.velocity = move_vec * MOVE_SPEED
	
	var look_vec = get_global_mouse_position() - global_position
	body.global_rotation = atan2(look_vec.y, look_vec.x)
	
	if Input.is_action_pressed("shoot"):
		gun.fire(look_vec.normalized())
func kill():
	get_tree().reload_current_scene()
