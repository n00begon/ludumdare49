extends life_object

func _init():
	self.species = 'bush'
	self.is_eaten_by = ['deer', 'moose', 'bear']
	self.scene = load("res://life/bush.tscn")
	self.get_node("WalkSprite").texture = load("res://assets/plants/bush.png")
	self.get_node("EatSprite").texture = load("res://assets/plants/bush.png")
