class_name plant_grass
extends KinematicBody2D

var rng = RandomNumberGenerator.new()
var health = 20
var debug = true

func find_label():
	var nc = self.get_child_count()
	for i in nc:
		var c = self.get_child(i)
		if c.is_class("Label"):
			return c

	return null

func _physics_process(delta):
	if debug:
		# HACK(Leon) I'm sorry :(
		var label = find_label()
		var labels = PoolStringArray([
			"health : %s"
		])

		var text = labels.join("\n")
		var label_str = text % [health]
		label.set_text(label_str)

func _on_EatRange_body_entered(body):
	pass
	# print("bush collide with ", body.name)
