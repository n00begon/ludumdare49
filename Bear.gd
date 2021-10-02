extends KinematicBody2D

var run_speed = 250
var velocity = Vector2.ZERO
var food = null
var rng = RandomNumberGenerator.new()
var walkCount = 100
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
		var label = find_label()
		var labels = PoolStringArray([
			"chasing food? : %s"
		])

		var text = labels.join("\n")
		var label_str = text % [food != null]
		label.set_text(label_str)

	if food:
		velocity = position.direction_to(food.position) * run_speed
	else:
		walkCount -= 1
		if walkCount < 0:
			walkCount = 100
			velocity = Vector2(rng.randf_range(-run_speed, run_speed), rng.randf_range(-run_speed, run_speed))
	move_and_slide(velocity)

	var game = get_parent()
	if Global.is_outside_viewport(position):
		queue_free()
		game._spawn_bear(true)

func _on_VisionArea_body_entered(body):
	if body.name.begins_with("prey"):
		food = body

func _on_VisionArea_body_exited(body):
	if body.name.begins_with("prey"):
		food = null

func _on_Bear_ready():
	pass
