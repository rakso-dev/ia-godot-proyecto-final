extends Node2D

#var player = null
#var DFS = null
#var BFS = null
#var greedy = null
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
		
	var vec_src = get_vecinity([int($Player.position.x), int($Player.position.y)])
	
	#########      DFS Block    #########
	var vec_DFS = get_vecinity([int($"Bot-DFS".position.x), int($"Bot-DFS".position.y)])
	var DFS_root = DFSTree.new(vec_DFS, turns, connections, [])
	var DFS_way = DFS_root.DFS(vec_src)
	DFS_way.invert()
	#DFS_way.pop_back()
	$"Bot-DFS".destiny = DFS_way
	######### end of DFS Block   #########
	#########     BFS Block      #########
	var vect_BFS = get_vecinity([int($"Bot-BFS".position.x), $"Bot-BFS".position.y])
	var BFS_root = BFSTree.new(vect_BFS, null, turns, connections)
	var BFS_way = BFS_root.BFS(vec_src)
	BFS_way.invert()
	#BFS_way.pop_back()
	$"Bot-BFS".destiny = BFS_way
	######### end of BFS Block   #########
	#########    Greedy Block    #########
	var vec_greedy = get_vecinity([int($"Bot-Greedy".position.x), int($"Bot-Greedy".position.y)])
	var greedy_root = GreedyTree.new(vec_greedy, vec_src, turns, connections)
	$"Bot-Greedy".destiny = greedy_root.greedy_search()
	######### end of greedy Block #########
	
#	clean_pos(vec_src)
#	clean_pos(vec_DFS)
#	clean_pos(vect_BFS)
#	clean_pos(vec_greedy)
	
	#reset_nodes()
	#print(connections.keys())
	
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
	connections[pos] = neighbors # esta cosa no esta metiendo la posicion en el diccionario ;-;
	connections[neighbors[0]].append(pos)
	connections[neighbors[1]].append(pos)
	return pos
		
	
func get_slope(src, node):
	var x = node[0] - src[0]
	var y = node[1] - src[1]
	if x or y == 0:
		return 0
	return x / y

func clean_pos(key):
	if len(connections.keys()) == 18:
		return
	if key in turns:
		return
	for item in connections[key]:
		connections[item].erase(key)
	connections.erase(key)
	
func reset_nodes():
		for key in connections.keys():
			if not key in turns:
				connections.erase(key)

class DFSTree:
	var turns
	var connections
	#var way = []
	var done
	var pos
	var branches
	
	func _init(pos, turns, connections, done):
		self.pos = pos
		self.turns = turns
		self.connections = connections
		self.done = done
		self.branches = []
		
	func expand():
		for item in connections[self.pos]:
			self.branches.append(DFSTree.new(item, self.turns, self.connections, self.done))
		
	func is_goal(goal):
		return self.pos == goal
		
	func DFS(goal):
		if not self.pos:
			return null
		if self.pos in done:
			return null
		var way = []
		if is_goal(goal):
			way.append(self.pos)
			return way
		done.append(self.pos)
		self.expand()
		for branch in self.branches:
			var tmp = branch.DFS(goal)
			if tmp:
				way.append(self.pos)
				way.append_array(tmp)
				return way
		return way

class BFSTree:
	var turns
	var connections
	var pos
	var branches
	var parent
	
	func _init(pos, parent, turns, connections):
		self.pos = pos
		self.parent = parent
		self.branches = []
		self.turns = turns
		self.connections = connections
		
	func expand():
		for item in connections[self.pos]:
			branches.append(BFSTree.new(item, self, self.turns, self.connections))
	
	func is_goal(goal):
		return self.pos == goal
		
	func get_way():
		if not self.parent:
			return [self.pos]
		var way = [self.pos]
		way.append_array(self.parent.get_way())
		return way
		
	func BFS(goal):
		var queue = []
		var visited = []
		queue.append(self)
		for element in queue:
			if element.is_goal(goal):
				return element.get_way()
			visited.append(element.pos)
			element.expand()
			for branch in element.branches:
				if not branch.pos in visited:
					queue.append(branch)
					
class GreedyTree:
	var pos
	var goal
	var distance
	var branches
	var turns
	var connections
	
	func _init(pos, goal, turns, connections):
		self.pos = pos
		self.goal = goal
		self.turns = turns
		self.connections = connections
		self.branches = []
		self.distance = self.get_distance()
		
	func get_distance():
		var x = pow((self.goal[0] - self.pos[0]), 2)
		var y = pow((self.goal[1] - self.pos[1]), 2)
		return pow(x + y, 0.5)
		
	func expand():
		for item in self.connections[self.pos]:
			self.branches.append(GreedyTree.new(item, self.goal, self.turns, self.connections))
			
	func greedy_search():
		if self.distance == 0:
			return [self.pos]
		self.expand()
		var shortest = self.branches[0]
		for branch in self.branches:
			if branch.distance < shortest.distance:
				shortest = branch
		var way = [self.pos]
		way.append_array(shortest.greedy_search())
		return way
		
	
			

class AS_Tree:
	var pos
	var goal
	var parent
	var distance
	var heuristics
	var cost
	var branches
	var turns
	var connections
	
	func _init(pos, goal, parent, turns, connections):
		self.pos = pos
		self.goal = goal
		self.parent = parent
		if self.parent:
			self.distance = self.get_distance(parent.pos)
			self.cost = parent.cost
		else:
			self.distance = 0
			self.cost = 0
		self.heuristics = self.get_distance(self.goal)
		self.cost += self.distance + self.heuristics
		self.branches = []
		
	func get_distance(point):
		var x = pow((point[0] - self.pos[0]), 2)
		var y = pow((point[1] - self.pos[1]), 2)
		return pow((x + y), 0.5)
		
	
