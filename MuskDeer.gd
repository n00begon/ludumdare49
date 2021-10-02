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

func _physics_process(delta):
	# HACK (Leon): yes this sucks. i don't know how to get the label good
	if debug:
		var label = self.get_child(4)
		var labels = PoolStringArray([
			"health : %s",
			"walkCount : %d"
		])

		var text = labels.join("\n")
		var label_str = text % [health, walkCount]
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
		# TODO(Leon): should turn into dead musk deer i guess?
		queue_free()

	move_and_slide(velocity)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		var ent = collision.collider
		if is_plant(ent):
			ent.health -= 1
			if ent.health <= 0:
				ent.queue_free()

	var game = get_parent()
	if Global.is_outside_viewport(position):
		queue_free()
		game._spawn_deer(true)


func _on_VisionArea_body_entered(body):
	if is_plant(body):
		if !food.has(body.name):
			food[body.name] = body

func _on_VisionArea_body_exited(body):
	if is_plant(body):
		if food.has(body.name):
			food.erase(body.name)

func _on_EatRange_body_entered(body):
	if is_pred(body):
		queue_free()
