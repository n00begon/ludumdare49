extends life_object
const texture = "res://assets/animals/fox/fox"

func _init():
	self.species = 'fox'
	self.is_eaten_by = ['tiger']
	self.eats = ['rabbit']
	self.scene = load("res://life/fox.tscn")
	self.run_speed = 400
	self.max_health = 200
	self.max_reproduction_rate = 50
	self.max_walk_count = 100
	self.get_node("WalkSprite").texture = load(texture + ".png")
	self.get_node("EatSprite").texture = load(texture + "-eat.png")
