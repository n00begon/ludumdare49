extends life_object
const texture = "res://assets/animals/fox/fox"

func _init():
	self.species = 'fox'
	self.is_eaten_by = ['tiger']
	self.eats = ['rabbit']
	self.scene = load("res://life/fox.tscn")
	self.run_speed = 400
	self.get_node("WalkSprite").texture = load(texture + ".png")
	self.get_node("EatSprite").texture = load(texture + "-eat.png")
