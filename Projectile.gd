extends Node2D


var direction
var speed = 400

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    $AnimatedSprite.rotation = direction.angle()
    global_position += direction * speed * delta

func destroy():
    queue_free()
    
func _on_Area2D_area_entered(area):
    destroy()


func _on_Area2D_body_entered(body):
    destroy()
    pass # Replace with function body.
