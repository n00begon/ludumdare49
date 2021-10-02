extends KinematicBody2D

var run_speed = 250
var velocity = Vector2.ZERO
var food = null
var rng = RandomNumberGenerator.new()
var walkCount = 100

func _physics_process(delta):
	if food:
		velocity = position.direction_to(food.position) * run_speed
	else:
		walkCount -= 1
		if walkCount < 0:
			walkCount = 100
			velocity = Vector2(rng.randf_range(-run_speed, run_speed), rng.randf_range(-run_speed, run_speed))
	move_and_slide(velocity)

func _on_VisionArea_body_entered(body):
	if body.name == "Bush":
		food = body

func _on_VisionArea_body_exited(body):
	if body.name == "Bush":
		food = null
