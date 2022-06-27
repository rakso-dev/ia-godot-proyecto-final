
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
    #creo que se puede hacer usando la distancia entre dos puntos, uno hacia atras y otro hacia la meta, solo hay que tomar en cuenta
    #que debe ser capaz de revisar los demas nodos y asi
    #pero para la deificion creo que funciona
    def __init__(self, pos, goal, parent):
        self.pos = tuple(pos)
        self.goal = tuple(goal)
        self.parent = parent
        if parent:
            self.distance = self.get_distance(parent.pos)
            self.cost = parent.cost
        else:
            self.distance = 0
            self.cost = 0
        self.heuristics = self.get_distance(self.goal)
        self.cost += self.distance + self.heuristics
        self.branches = []
    
    def get_distance(self, point):
        x = (point[0] - self.pos[0]) ** 2
        y = (point[1] - self.pos[1]) ** 2
        return (x + y) ** 0.5

    def expand(self):
        for item in connections[self.pos]:
            self.branches.append(TreeNode(item, self.goal, self))
    
    def get_way(self):
        if not self.parent:
            return [self.pos]
        way = [self.pos]
        way.extend(self.parent.get_way())
        return way

    def a_star(self):
        current = []
        done = []
        cheapest = None
        current.append(self)
        while (len(current) != 0):
            for item in current:
                if item.pos == self.goal:
                    if not cheapest:
                        cheapest = item
                    elif cheapest.cost > item.cost:
                        cheapest = item
                    continue
                item.expand()
                for branch in item.branches:
                    current.append(branch)
                done.append(item)
                current.remove(item)
            if cheapest:
                flag =  False
                for item in current:
                    if not (item == cheapest) and item.cost < cheapest.cost:
                        flag = True
                if flag == False:
                    break
        return cheapest.way()

root = TreeNode([928, 96], [352, 192], None)
way = root.a_star()
print(way)