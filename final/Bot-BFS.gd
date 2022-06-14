extends KinematicBody2D
var speed = 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var mov = Vector2()
	mov = mov.normalized()
	mov = move_and_slide(mov * speed)
