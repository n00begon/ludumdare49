class_name life_object
extends KinematicBody2D

# ====================================================
# FIELDS TO OVERRIDE
var species = '' # moose, deer, bear, bush, etc.
var eats = [] # moose, deer, bear, bush, etc.
var is_eaten_by = [] # moose, deer, bear, bush, etc.
var run_speed = 0 # should be zero for plants
var scene = null # e.g., load("res://life/moose.tscn")
var max_reproduction_rate = 100
var max_walk_count = 100
var max_health = 100
# ====================================================
var walkCount = 100
var health = 100
var rng = RandomNumberGenerator.new()
var velocity = Vector2.ZERO
var reproduction = 0
var food = []
var eating = []
var debug = true
var partners = []

const PLANT_SPAWN_CHANCE_PER_FRAME = 0.0001

const HEALTH_REPRODUCTION_PENALTY = 0.2
const HEALTH_REPRODUCTION_BASE = 0.5
const HEALTH_EATING_BOOST = 0.4

const SPAWN_VIEWPORT_BORDER_PADDING = 30

func _ready():
	rng.randomize()
	velocity = Vector2(rng.randf_range(-run_speed, run_speed), rng.randf_range(-run_speed, run_speed))
	reproduction = rng.randi_range(0, max_reproduction_rate)
	walkCount = rng.randi_range(0, max_walk_count)
	health = rng.randi_range(max_health * 0.9, max_health)

func find_label():
	var nc = self.get_child_count()
	for i in nc:
		var c = self.get_child(i)
		if c.is_class("Label"):
			return c
	return null

func _physics_process(delta):
	if Input.is_action_pressed("ui_easter_egg") and run_speed == 0:
		run_speed = 100

	health -= 0.05
	if eating.size() > 0:
		health += HEALTH_EATING_BOOST
		health = min(health, max_health)
	reproduction = max(reproduction - 1, 0)
	if debug:
		var label = find_label()
		var labels = PoolStringArray([
			"health : %s",
			"walkCount : %d",
			"partner? : %d",
			"chasing food? : %d",
			"reproduction cooldown : %s",
			"can reproduce: %s"
		])

		var text = labels.join("\n")
		var label_str = text % [health, walkCount, partners.size(), food.size(), reproduction, can_reproduce()]
		label.set_text(label_str)
	
	# Plant Reproduction
	if species in ['bush', 'grass', 'tree']:
		if reproduction == 0:
			reproduction = max_reproduction_rate
			spawn_copy(false, true)
	
	if partners.size() > 0:
		var closest_partner = null
		var closest_distance = 100000000000000000
		for p in partners:
			var distance = position.distance_to(p.position)
			if distance < closest_distance:
				closest_distance = distance
				closest_partner = p
		velocity = position.direction_to(closest_partner.position) * run_speed
	
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
		$WalkSprite.flip_h = true
		$EatSprite.flip_h = true
	else:
		$WalkSprite.flip_h = false
		$EatSprite.flip_h = false
	$WalkSprite.visible = true
	$EatSprite.visible = false
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		var ent = collision.collider

		# Being Eaten
		if ent.species in is_eaten_by:
			self.health -= 10
			if self.health <= 0:
				return self.die()

		# Eating
		if ent.species in eats:
			$WalkSprite.visible = false
			$EatSprite.visible = true
		

		# Reproduction
		if health >= max_health * HEALTH_REPRODUCTION_BASE && reproduction == 0:
			if ent.species == self.species:
				var partner = ent
				if partner.health >= partner.max_health * HEALTH_REPRODUCTION_BASE && partner.reproduction == 0:
						reproduction = max_reproduction_rate
						partner.reproduction = max_reproduction_rate
						spawn_copy(false, false)
						self.health *= HEALTH_REPRODUCTION_PENALTY
						ent.health *= HEALTH_REPRODUCTION_PENALTY

	# Respawn if outside the viewport
	if Global.is_outside_viewport(position):
		self.respawn()

func spawn_copy(isOffScreen: bool, ignoreSpeed: bool):
	if run_speed == 0 and not ignoreSpeed:
		# no spawn for static objects
		return
	var newObj = scene.instance()
	if Global.life_object_counter < Global.MAX_LIFE_OBJECTS:
		get_parent().add_child(newObj)
		Global.life_object_counter += 1

	if isOffScreen:
		newObj.health = self.health
	elif not ignoreSpeed:
		# Need to eat before reproducing
		newObj.health *= HEALTH_REPRODUCTION_BASE
	var viewport = get_viewport().size
	newObj.set_global_position(
		Global.gen_rnd_point()
	)

func respawn():
	self.spawn_copy(true, false)
	queue_free()
	Global.life_object_counter -= 1

func die():
	get_parent()._spawn_dead(species, position)
	queue_free()
	Global.life_object_counter -= 1

func can_reproduce() -> bool:
	return reproduction == 0 && health > max_health * HEALTH_REPRODUCTION_BASE

func _on_VisionArea_body_entered(body):
	if can_reproduce():
		if body.species == species && body.can_reproduce():
			partners.append(body)
	
	if (body.species in eats) and not (body in food):
		food.append(body)

func _on_VisionArea_body_exited(body):
	if body in food:
		food.erase(body)
	if body in partners:
		partners.erase(body)

func _on_EatRange_body_entered(body):
	if (body.species in eats) and not (body in eating):
		eating.append(body)

func _on_EatRange_body_exited(body):
	if body in eating:
		eating.erase(body)
