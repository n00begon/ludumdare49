extends KinematicBody2D

var rng = RandomNumberGenerator.new()
var health = 100
var debug = true

# TODO(Leon): restore our health over time (but capped at health max)
func _physics_process(delta):
	if debug:
		# HACK(Leon) I'm sorry :(
		var label = self.get_child(3)
		var labels = PoolStringArray([
			"health : %s"
		])

		var text = labels.join("\n")
		var label_str = text % [health]
		label.set_text(label_str)

func _on_EatRange_body_entered(body):
	pass
	# print("bush collide with ", body.name)
