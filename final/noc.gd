extends Node2D
var turns = [[96,96],
[224, 96],
[352, 96],
[928, 96],
[224, 192],
[352, 192],
[352, 224],
[672, 224],
[928, 224],
[96, 256],
[224, 256],
[224, 384],
[352, 384],
[672, 384],
[928, 384],
[96, 512],
[224, 512],
[928, 512]]

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var goal = $Player.position
	$"NodeBFS/Bot-BFS".destiny = $NodeBFS.BFSTree()
	

#func is_within(start, corner, goal):
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
