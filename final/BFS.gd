extends Node2D

#onready var map = $"../TileMap"
#onready var player = $"../Player"
#onready var bot = $"Bot-BFS"
#var mov = Vector2()
#var route = []
#var checked = {}
#var queue = []
#var speed = 0.5
#const MAX  = 5000
## Declare member variables here. Examples:
## var a = 2
## var b = "text"
#
#
## Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$"Bot-BFS".dest = 0
	#pendent var way = BFSTree.RecorreNiveles(BFSTree.new())
	pass
#	var map_pos
#	#Getting current position
#	map_pos = map.world_to_map(bot.global_position)
#	var bot_pos = {"x": int(round(map_pos.x)), "y": int(round(map_pos.y))}
#	#Getting goal position
#	map_pos = map.world_to_map(player.global_position)
#	var player_pos = {"x": int(round(map_pos.x)), "y": int(round(map_pos.y))}
#
#	route = []
#	route = bfs(bot_pos, player_pos)
#	position = bot.global_position
#
#	print(route)
#
#	if route.size() > 0:
#		var goal = map.map_to_world(Vector2(route[0].x, route[0].y) + Vector2(32, 32))
#		self.global_position = lerp(position, goal, delta/speed)
#
#func validate_pos(tile):
#	var cell_id = map.get_cell(tile.x, tile.y)
#	if cell_id == 5:
#		return cell_id
#func is_goal(curr_pos, last_pos, goal):
#	if !validate_pos(curr_pos):
#		return false
#	if str(curr_pos) in checked:
#		return false
#
#	checked[str(curr_pos)] = last_pos
#
#	if curr_pos.x == goal.x and curr_pos.y == goal.y:
#		return true
#
#	queue.push_back({"current": {"x": curr_pos.x, "y": curr_pos.y + 1}, "last": curr_pos})
#	queue.push_back({"current": {"x": curr_pos.x + 1, "y": curr_pos.y}, "last": curr_pos})
#	queue.push_back({"current": {"x": curr_pos.x, "y": curr_pos.y - 1}, "last": curr_pos})
#	queue.push_back({"current": {"x": curr_pos.x - 1, "y": curr_pos.y}, "last": curr_pos})
#
#func bfs(start, goal):
#	if !validate_pos(goal):
#		return []
#	queue = []
#	checked = {}
#	queue.push_back({"current": start, "last": null})
#
#	var it = 0
#
#	while queue.size() > 0:
#		var tile_pos = queue.pop_front()
#		if is_goal(tile_pos.current, tile_pos.last, goal):
#			break
#
#		it += 1
#
#		if it > MAX:
#			return []
#
#		var way = []
#		var curr_pos = goal
#
#		while str(curr_pos) in checked and checked[str(curr_pos)] != null:
#			if curr_pos != null:
#				way.append(curr_pos)
#			curr_pos = checked[str(curr_pos)]
#
#		way.invert()
#		return way
		
class BFSTree:
	var checked
	var graph
	var src
	var goal
	var parent
	
	func _init(src, goal, graph, parent, checked):
		self.src = src
		self.goal = goal
		self.graph = graph
		self.parent = parent
		self.checked = checked
		
	static func RecorreNiveles(currentLevel, visitados):
		var nextLevel = []
		var resp = null
		for item in currentLevel:
			resp = item.expande(nextLevel)
			if resp != null:
				return resp
		return RecorreNiveles(nextLevel, visitados)
		
	func expand(new_parent):
		if self.src == goal:
			return self
		
		self.checked.append(self)
		
		for source in self.graph[self.src]:
			if not (source in checked):
				new_parent.append(BFSTree.new(source, self.goal, self, self.graph, checked))
		return null
