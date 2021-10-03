extends life_object
const texture = "res://assets/animals/rabbit/rabbit"

func _init():
	self.species = 'rabbit'
	self.is_eaten_by = ['fox']
	self.eats = ['grass']
	self.scene = load("res://life/rabbit.tscn")
	self.run_speed = 600
	self.get_node("WalkSprite").texture = load(texture + ".png")
	self.get_node("EatSprite").texture = load(texture + "-eat.png")
