extends life_object

func _init():
	self.species = 'tree'
	self.is_eaten_by = ['moose']
	self.scene = load("res://life/tree.tscn")
	# For some weird reason, randomize() doesn't work and we're always getting the same random number
	# here, so I replaced it with OS.get_time().second
	var choose = OS.get_time().second % 3
	var texture = null
	match choose:
		0: texture = load("res://assets/plants/sapling.png")
		1: texture = load("res://assets/plants/tree-1.png")
		2: texture = load("res://assets/plants/tree-2.png")
	self.get_node("Sprite").texture = texture
