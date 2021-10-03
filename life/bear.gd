extends life_object

func _init():
	self.species = 'bear'
	self.is_eaten_by = []
	self.eats = ['moose', 'deer']
	self.scene = load("res://life/bear.tscn")
	self.run_speed = 250
	self.get_node("Sprite").texture = load("res://assets/animals/bear/new-bear.png")
