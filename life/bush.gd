extends life_object

func _init():
	self.max_reproduction_rate = 500
	self.max_health = 100
	self.species = 'bush'
	self.is_eaten_by = ['deer', 'moose', 'bear']
	self.scene = load("res://life/bush.tscn")
	self.rng.randomize()
	var choose = self.rng.randi() % 3
	var texture = null
	match choose:
		0:
			texture = load("res://assets/plants/bush.png")
			self.texture_name = 'bush'
		1:
			texture = load("res://assets/plants/bush-2.png")
			self.texture_name = 'bush2'
		2:
			texture = load("res://assets/plants/bush-3.png")
			self.texture_name = 'bush3'
	self.get_node("WalkSprite").texture = texture
	self.get_node("EatSprite").texture = texture
