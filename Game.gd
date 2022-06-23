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
	
func _process(delta):
	#$"Bot-BFS".destiny = [turns[5], turns[2]]
	#$"Bot-AS".destiny = [turns[5]]
	
	var vec_src = get_vecinity([int($Player.position.x), int($Player.position.y)])
	#var vec_BFS = get_vecinity([int($"Bot-BFS".position.x), int($"Bot-BFS".position.y)])
	#print("src: {str}".format({"str": str(connections[vec_src])}))
	#print("dest: {str}".format({"str": str(connections[vec_BFS])}))
	DFSTree.turns = turns
	DFSTree.connections = connections
	var vec_DFS = get_vecinity([int($"Bot-DFS".position.x), int($"Bot-DFS".position.y)])
	var DFS_root = DFSTree.new(vec_DFS)
	DFS_root.DFS(vec_src)
	DFSTree.way.invert()
	$"Bot-DFS".destiny = DFSTree.way
	
	
func is_between(p1, p2, pos):
	if get_slope(p1, p2) != 0 and get_slope(p1, pos) !=0:
		return false
	var minimum
	var maximum
	if p1[0] == p2[0]:
		maximum = max(p1[1], p2[1])
		minimum = min(p1[1], p2[1])
		if pos[1] > minimum and pos[1] < maximum:
			return true
	if p1[1] == p2[1]:
		maximum = max(p1[0], p2[0])
		minimum = min(p1[0], p2[0])
		if pos[0] > minimum and pos[0] < maximum:
			return true
	return false
		
func get_vecinity(pos):
	var neighbors = []
	for key in connections.keys():
		if pos[0] == key[0] and pos[1] == key[1]:
			return key
		for n in connections[key]:
			if is_between(key, n, pos):
				neighbors.append(key)
				neighbors.append(n)
				break
	connections[pos] = neighbors
	connections[neighbors[0]].append(pos)
	connections[neighbors[1]].append(pos)
	return pos
		
	
func get_slope(src, node):
	var x = node[0] - src[0]
	var y = node[1] - src[1]
	if x or y == 0:
		return 0
	return x / y


###### No existen las variables de clase, solo de instancia, hacer modificaciones ###########
class DFSTree:
	var turns
	var connections
	var way
	var done
	var pos
	var branches
	
	func _init(pos):
		self.pos = pos
		self.branches = []
		
	func expand():
		for item in connections[self.pos]:
			self.branches.append(item)
		
	func is_goal(goal):
		return self.pos == goal
		
	func DFS(goal):
		if not self.pos:
			return false
		if self.pos in done:
			return false
		if is_goal(goal):
			way.append(self.pos)
			return true
		done.append(self.pos)
		self.expand()
		for branch in self.branches:
			if branch.DFS(goal):
				way.append(goal)
				return true
		return false
