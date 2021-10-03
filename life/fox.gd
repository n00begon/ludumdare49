extends life_object

func _init():
	self.species = 'fox'
	self.is_eaten_by = ['tiger']
	self.eats = ['rabbit']
	self.scene = load("res://life/fox.tscn")
	self.run_speed = 400
	self.get_node("Sprite").texture = load("res://assets/animals/fox/fox.png")
