extends life_object
const texture = "res://assets/animals/beaver/beaver"

func _init():
	self.species = 'beaver'
	self.is_eaten_by = ['tiger', 'bear', 'fox']
	self.eats = ['tree']
	self.scene = load("res://life/beaver.tscn")
	self.run_speed = 50
	self.get_node("WalkSprite").texture = load(texture + ".png")
	self.get_node("EatSprite").texture = load(texture + "-eat.png")

