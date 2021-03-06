extends life_object
const texture = "res://assets/animals/moose/new-deer"

func _init():
	self.species = 'moose'
	self.texture_name = 'moose'
	self.is_eaten_by = ['tiger', 'bear']
	self.eats = ['bush', 'tree']
	self.scene = load("res://life/moose.tscn")
	self.run_speed = 250
	self.max_health = 100
	self.max_reproduction_rate = 30
	self.max_walk_count = 200
	self.get_node("WalkSprite").texture = load(texture + ".png")
	self.get_node("EatSprite").texture = load(texture + "-eat.png")
