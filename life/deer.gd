extends life_object
const texture = "res://assets/animals/deer/actual-deer"

func _init():
	self.species = 'deer'
	self.is_eaten_by = ['bear', 'tiger']
	self.eats = ['bush', 'grass']
	self.scene = load("res://life/deer.tscn")
	self.run_speed = 400
	self.get_node("WalkSprite").texture = load(texture + ".png")
	self.get_node("EatSprite").texture = load(texture + "-eat.png")
