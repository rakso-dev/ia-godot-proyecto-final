extends KinematicBody2D
var speed = 100
var mov = Vector2()
var destiny = null
var curr_destination = null
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if destiny == null:
		return
	if curr_destination == null:
		curr_destination = destiny.pop_back()
	move_control()
	move_and_collide(mov * delta)
	
func move_control():
	var delta_x = self.position.x - curr_destination[0]
	var delta_y = self.position.y - curr_destination[1]
	
	if abs(delta_x) <= 1 and abs(delta_x) >=0 and abs(delta_y) <= 1 and abs(delta_y) >= 0:
		mov.x = 0
		mov.y = 0
		self.position.x = curr_destination[0]
		self.position.y = curr_destination[1]
		
		curr_destination = destiny.pop_back()
		print(curr_destination)
		return
	
	if delta_x == 0:
		if delta_y > 0:
			mov.y = -speed
			mov.x = 0
		else:
			mov.y = speed
			mov.x = 0
	else:
		if delta_x > 0:
			mov.y = 0
			mov.x = -speed
		else:
			mov.y = 0
			mov.x = speed
