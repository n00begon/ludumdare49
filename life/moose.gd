extends life_object
const texture = "res://assets/animals/moose/new-deer"

func _init():
	self.species = 'moose'
	self.is_eaten_by = ['tiger']
	self.eats = ['bush', 'tree']
	self.scene = load("res://life/moose.tscn")
	self.run_speed = 250
	self.get_node("WalkSprite").texture = load(texture + ".png")
	self.get_node("EatSprite").texture = load(texture + "-eat.png")
