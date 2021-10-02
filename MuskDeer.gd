extends KinematicBody2D

var run_speed = 250
var velocity = Vector2.ZERO
var rng = RandomNumberGenerator.new()
var walkCount = 100
var food = {}

func _physics_process(delta):
	if food.values().size() > 0:
		var closest_food = null
		var closest_distance = 100000000000000000
		for f in food.values():
			var distance = position.distance_to(f.position)
			if distance < closest_distance:
				closest_distance = distance
				closest_food = f
		velocity = position.direction_to(closest_food.position) * run_speed
	else:
		walkCount -= 1
		if walkCount < 0:
			walkCount = 100
			velocity = Vector2(rng.randf_range(-run_speed, run_speed), rng.randf_range(-run_speed, run_speed))
	move_and_slide(velocity)

func _on_VisionArea_body_entered(body):
	if body.name.match("plant*"):
		if !food.has(body.name):
			food[body.name] = body

func _on_VisionArea_body_exited(body):
	if body.name.match("plant*"):
			if food.has(body.name):
				food.erase(body.name)
