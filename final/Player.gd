extends KinematicBody2D


var mov = Vector2()
var speed = 64

func _process(delta):
	mov.x = 0
	mov.y = 0
	if Input.action_press("ui_right"):
		mov.x = speed
		mov.y = 0
	if Input.action_press("ui_down"):
		mov.y = speed
		mov.x = 0
	if Input.action_press("ui_left"):
		mov.x = -1 * speed
		mov.y = 0
	if Input.action_press("ui_up"):
		mov.y = -1 * speed
		mov.x = 0
	move_and_collide(mov)
