extends KinematicBody2D


var mov = Vector2()
var speed = 32

func _process(delta):
	mov.x = 0
	mov.y = 0
	if collides_with_enemy():
		get_tree().change_scene("res://You_Lost.tscn")
	if Input.is_action_just_pressed("ui_right"):
		mov.x = speed
		mov.y = 0
	if Input.is_action_just_pressed("ui_down"):
		mov.y = speed
		mov.x = 0
	if Input.is_action_just_pressed("ui_left"):
		mov.x = -1 * speed
		mov.y = 0
	if Input.is_action_just_pressed("ui_up"):
		mov.y = -1 * speed
		mov.x = 0
	move_and_collide(mov)

func collides_with_enemy():
	if $right.is_colliding():
		var right = $right.get_collider()
		if right and right.is_in_group("enemy"):
			return true
	if $down.is_colliding():
		var down = $down.get_collider()
		if down and down.is_in_group("enemy"):
			return true
	if $left.is_colliding():
		var left = $left.get_collider()
		if left and left.is_in_group("enemy"):
			return true
	if $up.is_colliding():
		var up = $up.get_collider()
		if up and up.is_in_group("enemy"):
			return true
	return false
