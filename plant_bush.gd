extends KinematicBody2D

var rng = RandomNumberGenerator.new()
var health = 100

func _on_EatRange_body_entered(body):
	print("bush collide with ", body.name)
	#if body.name.match("prey*"):
	#	queue_free()
