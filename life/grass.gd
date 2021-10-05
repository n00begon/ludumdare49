extends life_object

func _init():
	self.max_reproduction_rate = 100
	self.max_health = 50
	self.species = 'grass'
	self.is_eaten_by = ['deer', 'rabbit']
	self.scene = load("res://life/grass.tscn")
	self.rng.randomize()
	self.get_node("WalkSprite").texture = load("res://assets/plants/grass.png")
	self.get_node("EatSprite").texture = load("res://assets/plants/grass.png")

	var choose = self.rng.randi() % 6
	var texture = null
	match choose:
		0:
			texture = load("res://assets/plants/grass.png")
			self.texture_name = 'grass'
		1:
			texture = load("res://assets/plants/grass2.png")
			self.texture_name = 'grass2'
		2:
			texture = load("res://assets/plants/grass3.png")
			self.texture_name = 'grass3'
		3:
			texture = load("res://assets/plants/grass4.png")
			self.texture_name = 'grass4'
		4:
			texture = load("res://assets/plants/grass5.png")
			self.texture_name = 'grass5'
		5:
			texture = load("res://assets/plants/grass6.png")
			self.texture_name = 'grass6'
	self.get_node("WalkSprite").texture = texture
	self.get_node("EatSprite").texture = texture
