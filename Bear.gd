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
	
	var game = get_parent().get_node("Game")
	if game._is_outside_viewport(position):
		queue_free()
		game._spawn_bear(true)

func _on_VisionArea_body_entered(body):
	if body.name.begins_with("prey"):
		modulate = Color(1, 0, 0, 1)
		food = body
		body.health -= 1

func _on_VisionArea_body_exited(body):
	if body.name.begins_with("prey"):
		modulate = Color(1, 1, 1, 1)
		food = null

func _on_Bear_ready():
	pass
