extends life_object
const texture = "res://assets/animals/tiger/tiger"

func _init():
	self.species = 'tiger'
	self.texture_name = 'tiger'
	self.is_eaten_by = []
	self.eats = ['bear', 'fox', 'deer', 'moose']
	self.scene = load("res://life/tiger.tscn")
	self.run_speed = 350
	self.max_health = 150
	self.max_reproduction_rate = 100
	self.max_walk_count = 300
	self.get_node("WalkSprite").texture = load(texture + ".png")
	self.get_node("EatSprite").texture = load(texture + "-eat.png")
