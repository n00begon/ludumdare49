extends life_object

func _init():
	self.species = 'grass'
	self.is_eaten_by = ['deer', 'rabbit']
	self.scene = load("res://life/grass.tscn")
	self.rng.randomize()
	self.get_node("WalkSprite").texture = load("res://assets/plants/grass.png")
	self.get_node("EatSprite").texture = load("res://assets/plants/grass.png")

	var choose = self.rng.randi() % 5
	var texture = null
	match choose:
		0: texture = load("res://assets/plants/grass.png")
		1: texture = load("res://assets/plants/grass2.ppng")
		2: texture = load("res://assets/plants/grass3.png")
		3: texture = load("res://assets/plants/grass3.png")
		4: texture = load("res://assets/plants/grass5.png")
	self.get_node("WalkSprite").texture = texture
	self.get_node("EatSprite").texture = texture
