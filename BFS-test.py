
#graph nodes
turns = [[96,96], #0
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
connections = {
	tuple(turns[0]): [turns[1], turns[9], turns[15]],
	tuple(turns[1]): [turns[0], turns[4], turns[10], turns[11], turns[16]],
	tuple(turns[2]): [turns[3], turns[5], turns[6], turns[12]],
	tuple(turns[3]): [turns[2]],
	tuple(turns[4]): [turns[1], turns[5], turns[10], turns[11], turns[16]],
	tuple(turns[5]): [turns[2], turns[4], turns[6], turns[12]],
	tuple(turns[6]): [turns[2], turns[5], turns[7], turns[7], turns[8]],
	tuple(turns[7]): [turns[6], turns[8], turns[13]],
	tuple(turns[8]): [turns[6], turns[7]],
	tuple(turns[9]): [turns[0], turns[10], turns[15]],
	tuple(turns[10]): [turns[1], turns[4], turns[9], turns[11], turns[16]],
	tuple(turns[11]): [turns[1], turns[4], turns[10], turns[12], turns[13], turns[14]],
	tuple(turns[12]): [turns[2], turns[5], turns[6], turns[11], turns[13], turns[14]],
	tuple(turns[13]): [turns[7], turns[11], turns[12], turns[14]],
	tuple(turns[14]): [turns[11], turns[12], turns[13], turns[17]],
	tuple(turns[15]): [turns[0], turns[9], turns[16], turns[17]],
	tuple(turns[16]): [turns[1], turns[4], turns[10], turns[11], turns[15], turns[17]],
	tuple(turns[17]): [turns[14], turns[15], turns[16]]
}

class TreeNode:

	def __init__(self, pos, parent) -> None:
		self.pos = tuple(pos)
		self.parent = parent
		self.branches = []

	def expand(self):
		for turn in connections[self.pos]:
			self.branches.append(TreeNode(turn, self))

	def is_goal(self, goal):
		return self.pos == tuple(goal)

	def get_way(self):
		if not self.parent:
			return [self.pos]
		way = [self.pos]
		way.extend(self.parent.get_way())
		return way

	def BFS(self, goal):
		queue = []
		visited = []
		queue.append(self)
		for element in queue:
			if element.is_goal(goal):
				return element.get_way()
			visited.append(element.pos)
			element.expand()
			for branch in element.branches:
				if not branch.pos in visited:
					queue.append(branch)

root = TreeNode([928, 96], None)
way = root.BFS([352, 192])
way.reverse()

for e in way:
    print(e)
