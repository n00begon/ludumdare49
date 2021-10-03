extends life_object

func _init():
	self.species = 'moose'
	self.is_eaten_by = ['bear']
	self.eats = ['bush', 'grass', 'tree']
	self.scene = load("res://life/moose.tscn")
	self.run_speed = 250
	self.get_node("Sprite").texture = load("res://assets/animals/moose/new-deer.png")
