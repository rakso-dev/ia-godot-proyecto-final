extends KinematicBody2D
var speed = 10
var mov = Vector2()
var destiny = null
# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(delta):
	var mov = Vector2()
	#mov = mov.normalized()
	mov = move_and_collide(mov * speed)
