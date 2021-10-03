extends life_object

func _init():
	self.species = 'rabbit'
	self.is_eaten_by = ['bear']
	self.eats = ['bush', 'grass', 'tree']
	self.scene = load("res://life/rabbit.tscn")
	self.run_speed = 600
	self.get_node("Sprite").texture = load("res://assets/animals/rabbit/rabbit.png")
