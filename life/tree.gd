extends life_object

func _init():
	self.species = 'tree'
	self.is_eaten_by = ['deer', 'moose', 'rabbit']
	self.scene = load("res://life/tree.tscn")
	var choose = self.rng.randi() % 3
	var texture = null
	match choose:
		1: texture = load("res://assets/plants/sapling.png")
		2: texture = load("res://assets/plants/tree-1.png")
		3: texture = load("res://assets/plants/tree-2.png")
	self.get_node("Sprite").texture = texture
