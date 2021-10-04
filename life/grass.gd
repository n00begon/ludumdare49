extends life_object

func _init():
	self.max_reproduction_rate = 100
	self.max_health = 20
	self.species = 'grass'
	self.is_eaten_by = ['deer', 'rabbit']
	self.scene = load("res://life/grass.tscn")
	self.rng.randomize()
	self.get_node("WalkSprite").texture = load("res://assets/plants/grass.png")
	self.get_node("EatSprite").texture = load("res://assets/plants/grass.png")

	var choose = self.rng.randi() % 6
	var texture = null
	match choose:
		0: texture = load("res://assets/plants/grass.png")
		1: texture = load("res://assets/plants/grass2.png")
		2: texture = load("res://assets/plants/grass3.png")
		3: texture = load("res://assets/plants/grass4.png")
		4: texture = load("res://assets/plants/grass5.png")
		5: texture = load("res://assets/plants/grass6.png")
	self.get_node("WalkSprite").texture = texture
	self.get_node("EatSprite").texture = texture
