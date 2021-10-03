extends life_object

func _init():
	self.species = 'tree'
	self.is_eaten_by = ['moose']
	self.scene = load("res://life/tree.tscn")
	self.rng.randomize()
	var choose = self.rng.randi() % 3
	var texture = null
	match choose:
		0: texture = load("res://assets/plants/sapling.png")
		1: texture = load("res://assets/plants/tree-1.ppng")
		2: texture = load("res://assets/plants/tree-2.png")
	self.get_node("WalkSprite").texture = texture
	self.get_node("EatSprite").texture = texture
