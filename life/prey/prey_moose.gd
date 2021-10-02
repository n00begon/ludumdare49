class_name prey_moose
extends KinematicBody2D

var run_speed = 250
var velocity = Vector2.ZERO
var rng = RandomNumberGenerator.new()
var walkCount = 100
var health = 100
var food = {}
var debug = true

# TODO:(Leon) this sucks. can we just extend entity and put an type enum on them?
# also can thses functions be global?
func is_plant(entity):
	return entity.name.match("plant*")

func is_pred(entity):
	return entity.name.match("pred*")

func is_prey(entity):
	return entity.name.match("prey*")

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
			"health : %s",
			"walkCount : %d",
			"chasing food? : %d"
		])

		var text = labels.join("\n")
		var label_str = text % [health, walkCount, food.size()]
		label.set_text(label_str)

	
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

	if health <= 0:
		return self.die()

	move_and_slide(velocity)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		var ent = collision.collider
		if is_plant(ent):
			ent.health -= 1
			if ent.health <= 0:
				ent.queue_free()
		elif is_pred(ent):
			self.health -= 1
			if self.health <= 0:
				return self.die()

	var game = get_parent()
	if Global.is_outside_viewport(position):
		queue_free()
		game._spawn_moose(true)

func die():
	var game = get_parent()
	game._spawn_dead("moose", position)
	queue_free()

func _on_VisionArea_body_entered(body):
	if is_plant(body):
		if !food.has(body.name):
			food[body.name] = body

func _on_VisionArea_body_exited(body):
	if is_plant(body):
		if food.has(body.name):
			food.erase(body.name)

func _on_EatRange_body_entered(body):
	pass
	# if is_pred(body):
	# queue_free()
