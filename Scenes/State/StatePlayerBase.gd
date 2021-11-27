extends "res://Scenes/State/State.gd"


func update(delta):
    var move_vec = Vector2()
    
    if Input.is_action_pressed("move_up"):
        move_vec.y -= 1
    if Input.is_action_pressed("move_down"):
        move_vec.y += 1
    if Input.is_action_pressed("move_left"):
        move_vec.x -= 1
    if Input.is_action_pressed("move_right"):
        move_vec.x += 1
        
    move_vec = move_vec.normalized()
    body.velocity = body.velocity.linear_interpolate(move_vec * controller.move_speed, delta * 10)
    
    if(move_vec != Vector2.ZERO):
        controller.sprite.play("walk")
    else:
        controller.sprite.play("idle")
    var look_vec = controller.get_global_mouse_position() - body.global_position
    controller.gun.position = look_vec.normalized() * 10
    
    
    if Input.is_action_pressed("shoot"):
        controller.shoot(look_vec.normalized())
