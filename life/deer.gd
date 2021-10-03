extends life_object

func _init():
	self.species = 'deer'
	self.is_eaten_by = ['bear']
	self.eats = ['bush', 'grass', 'tree']
	self.scene = load("res://life/deer.tscn")
	self.run_speed = 400
	self.get_node("Sprite").texture = load("res://assets/animals/deer/actual-deer.png")
