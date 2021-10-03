class_name life_object
extends KinematicBody2D

# ====================================================
# FIELDS TO OVERRIDE
var species = '' # moose, deer, bear, bush, etc.
var eats = [] # moose, deer, bear, bush, etc.
var is_eaten_by = [] # moose, deer, bear, bush, etc.
var run_speed = 0 # should be zero for plants
var scene = null # e.g., load("res://life/moose.tscn")
# ====================================================

var rng = RandomNumberGenerator.new()
var velocity = Vector2.ZERO
var walkCount = 100
var health = 100
var food = []
var debug = true

const HEALTH_REPRODUCTION_PENALTY = 50
const HEALTH_EATING_BOOST = 0.5

# NOTE : our lifetime is short so this means one baby only i guess?
const FEMALE = 0
const MALE = 1
var gender = FEMALE
const MAX_PREGNANCY_COOLDOWN = 100
var pregnancy_cooldown = MAX_PREGNANCY_COOLDOWN

const SPAWN_VIEWPORT_BORDER_PADDING = 30

func _ready():
	rng.randomize()
	velocity = Vector2(rng.randf_range(-run_speed, run_speed), rng.randf_range(-run_speed, run_speed))

func find_label():
	var nc = self.get_child_count()
	for i in nc:
		var c = self.get_child(i)
		if c.is_class("Label"):
			return c
	return null

func _physics_process(delta):	
	health -= 0.05
	pregnancy_cooldown -= 1
	if debug:
		var label = find_label()
		var labels = PoolStringArray([
			"health : %s",
			"walkCount : %d",
			"chasing food? : %d",
			"pregnancy cooldown : %s",
			"gender : %s"
		])

		var text = labels.join("\n")
		var label_str = text % [health, walkCount, food.size(), pregnancy_cooldown, self.gender]
		label.set_text(label_str)
	
	if food.size() > 0:
		var closest_food = null
		var closest_distance = 100000000000000000
		for f in food:
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
	if velocity.x < 0:
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		var ent = collision.collider

		# Eating
		if ent.species in is_eaten_by:
			self.health -= 1
			if self.health <= 0:
				return self.die()

		# Reproduction
		if ent.species == self.species and ent.gender != self.gender:
			# which one is the female
			var female = ent
			if female.gender != FEMALE:
				female = self

			if female.pregnancy_cooldown < 0:
				female.pregnancy_cooldown = MAX_PREGNANCY_COOLDOWN
				female.spawn_copy(false)
				self.health -= HEALTH_REPRODUCTION_PENALTY
				ent.health -= HEALTH_REPRODUCTION_PENALTY

	# Respawn if outside the viewport
	if Global.is_outside_viewport(position):
		self.respawn()

func spawn_copy(isOffScreen):
	if run_speed == 0:
		# no spawn for static objects
		return
	var newObj = scene.instance()
	if isOffScreen:
		newObj.gender = self.gender
		newObj.health = self.health
	else:
		newObj.gender = rng.randi() % 2
	var viewport = get_viewport().size
	newObj.set_global_position(
		Vector2(
			rng.randi_range(SPAWN_VIEWPORT_BORDER_PADDING, viewport.x - SPAWN_VIEWPORT_BORDER_PADDING),
			rng.randi_range(SPAWN_VIEWPORT_BORDER_PADDING, viewport.y - SPAWN_VIEWPORT_BORDER_PADDING)
		)
	)
	if rng.randi_range(0,1) == 1:
		$Sprite.flip_h = true
	if Global.life_object_counter < Global.MAX_LIFE_OBJECTS:
		get_parent().add_child(newObj)
		Global.life_object_counter += 1

func respawn():
	self.spawn_copy(true)
	queue_free()
	Global.life_object_counter -= 1

func die():
	get_parent()._spawn_dead(species, position)
	queue_free()
	Global.life_object_counter -= 1

func _on_VisionArea_body_entered(body):
	if (body.species in eats) and not (body in food):
		food.append(body)

func _on_VisionArea_body_exited(body):
	if body in food:
		food.erase(body)

func _on_EatRange_body_entered(body):
	pass
