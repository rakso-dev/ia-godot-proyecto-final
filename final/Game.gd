extends Node2D

#graph nodes
var turns = [[96,96], #0
[224, 96], #1
[352, 96], #2
[928, 96], #3
[224, 192], #4
[352, 192], #5
[352, 224], #6
[672, 224], #7
[928, 224], #8
[96, 256], #9
[224, 256], #10
[224, 384], #11
[352, 384], #12
[672, 384], #13
[928, 384], #14
[96, 512], #15
[224, 512], #16
[928, 512]] #17

#vecinity map
var connections = {
	turns[0]: [turns[1], turns[9], turns[15]],
	turns[1]: [turns[0], turns[4], turns[10], turns[11], turns[16]],
	turns[2]: [turns[3], turns[5], turns[6], turns[12]],
	turns[3]: [turns[2]],
	turns[4]: [turns[1], turns[5], turns[10], turns[11], turns[16]],
	turns[5]: [turns[2], turns[4], turns[6], turns[12]],
	turns[6]: [turns[2], turns[5], turns[7], turns[7], turns[8]],
	turns[7]: [turns[6], turns[8], turns[13]],
	turns[8]: [turns[6], turns[7]],
	turns[9]: [turns[0], turns[10], turns[15]],
	turns[10]: [turns[1], turns[4], turns[9], turns[11], turns[16]],
	turns[11]: [turns[1], turns[4], turns[10], turns[12], turns[13], turns[14]],
	turns[12]: [turns[2], turns[5], turns[6], turns[11], turns[13], turns[14]],
	turns[13]: [turns[7], turns[11], turns[12], turns[14]],
	turns[14]: [turns[11], turns[12], turns[13], turns[17]],
	turns[15]: [turns[0], turns[9], turns[16], turns[17]],
	turns[16]: [turns[1], turns[4], turns[10], turns[11], turns[15], turns[17]],
	turns[17]: [turns[14], turns[15], turns[16]]
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	var goal = $Player.position
	#$"NodeBFS/Bot-BFS".destiny = $NodeBFS.BFSTree()
	
func is_within(goal):
	var nearest = []
	for node in turns:
		if node[0] == int(goal.x) and node[1] == int(node.y):
			return node
		if get_pendent(goal, node):
			nearest.append(node)
	return nearest
	
func get_pendent(src, node):
	var x = node[0] - int(src.x)
	var y = node[1] - int(src.y)
	if x or y == 0:
		return 0
	return x / y
#func is_within(start, corner, goal):
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
