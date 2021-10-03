extends life_object
const texture = "res://assets/animals/rabbit/rabbit"

func _init():
	self.species = 'rabbit'
	self.is_eaten_by = ['fox']
	self.eats = ['grass']
	self.scene = load("res://life/rabbit.tscn")
	self.run_speed = 400
	self.max_health = 20
	self.max_reproduction_rate = 5
	self.max_walk_count = 5
	self.get_node("WalkSprite").texture = load(texture + ".png")
	self.get_node("EatSprite").texture = load(texture + "-eat.png")
