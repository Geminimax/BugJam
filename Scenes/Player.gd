extends Node2D


const MOVE_SPEED = 300

onready var raycast = $Body/RayCast2D
onready var body = $Body
onready var gun = $Body/Gun
var cooldown = 0.5
var current_cooldown = 0
 
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
	
	var look_vec = get_global_mouse_position() - body.global_position
	body.global_rotation = atan2(look_vec.y, look_vec.x)
	
	if Input.is_action_pressed("shoot"):
		if current_cooldown <= 0:
			gun.fire(look_vec.normalized())
			current_cooldown = cooldown
		
	current_cooldown -= delta
func kill():
	get_tree().reload_current_scene()
