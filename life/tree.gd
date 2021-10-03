extends life_object

func _init():
	self.species = 'tree'
	self.is_eaten_by = ['moose']
	self.scene = load("res://life/tree.tscn")
	self.rng.randomize()
	var choose = self.rng.randi() % 8
	var texture = null
	match choose:
		0: texture = load("res://assets/plants/sapling.png")
		1: texture = load("res://assets/plants/tree-1.ppng")
		2: texture = load("res://assets/plants/tree-2.png")
		3: texture = load("res://assets/plants/tree-3.png")
		4: texture = load("res://assets/plants/tree-4.png")
		5: texture = load("res://assets/plants/tree-5.png")
		6: texture = load("res://assets/plants/tree-6.png")
		7: texture = load("res://assets/plants/tree-7.png")
	self.get_node("WalkSprite").texture = texture
	self.get_node("EatSprite").texture = texture
