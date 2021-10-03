extends life_object

func _init():
	self.species = 'tiger'
	self.is_eaten_by = []
	self.eats = ['bear', 'fox', 'deer', 'moose']
	self.scene = load("res://life/tiger.tscn")
	self.run_speed = 350
	self.get_node("Sprite").texture = load("res://assets/animals/tiger/tiger.png")
