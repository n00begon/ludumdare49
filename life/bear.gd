extends life_object
const texture = "res://assets/animals/bear/new-bear"

func _init():
	self.species = 'bear'
	self.texture_name = 'bear'
	self.is_eaten_by = ['tiger']
	self.eats = ['bush', 'deer', 'moose', 'fox', 'beaver']
	self.scene = load("res://life/bear.tscn")
	self.run_speed = 250
	self.max_health = 100
	self.max_reproduction_rate = 200
	self.max_walk_count = 100
	self.get_node("WalkSprite").texture = load(texture + ".png")
	self.get_node("EatSprite").texture = load(texture + "-eat.png")

