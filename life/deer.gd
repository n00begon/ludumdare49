extends life_object

func _init():
	self.species = 'deer'
	self.is_eaten_by = ['bear', 'tiger']
	self.eats = ['bush', 'grass']
	self.scene = load("res://life/deer.tscn")
	self.run_speed = 400
	self.get_node("Sprite").texture = load("res://assets/animals/deer/actual-deer.png")
