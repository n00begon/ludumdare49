extends KinematicBody2D

var rng = RandomNumberGenerator.new()
var health = 100

# TODO(Leon): restore our health over time (but capped at health max)

func _on_EatRange_body_entered(body):
	pass
	# print("bush collide with ", body.name)
