extends life_object

func _init():
	self.species = 'bush'
	self.is_eaten_by = ['deer', 'moose', 'rabbit']
	self.scene = load("res://life/bush.tscn")
	self.get_node("Sprite").texture = load("res://assets/plants/bush.png")
