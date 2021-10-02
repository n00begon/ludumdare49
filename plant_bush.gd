extends KinematicBody2D

var rng = RandomNumberGenerator.new()

func _on_EatRange_body_entered(body):
	print(body.name)
	if body.name.match("prey*"):
		queue_free()
