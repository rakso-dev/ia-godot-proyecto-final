extends KinematicBody2D

var graph
var visited
var src
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

class DFSTree:
	var src
	var goal
	var parent
	var graph
	var checked
	
	func _init(src, goal, parent, graph, checked):
		self.src = src
		self.goal = goal
		self.parent = parent
		self.graph = graph
		self.checked = checked
		
	func expand():
		if self.src == self.goal:
			return self
		self.checked.append(self.src)
		var route = null
		for child in self.graph[self.src]:
			if child in self.checked:
				continue
			route = DFSTree.new(child, self.goal, self, self.graph, checked).expand()
			if route != null:
				return route
		return route
