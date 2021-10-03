extends life_object

func _init():
	self.species = 'grass'
	self.is_eaten_by = ['deer', 'rabbit']
	self.scene = load("res://life/grass.tscn")
	self.get_node("Sprite").texture = load("res://assets/plants/grass.png")
