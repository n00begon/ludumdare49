class_name pred_bear
extends KinematicBody2D

const FEMALE = 0
const MALE = 1

var run_speed = 250
var velocity = Vector2.ZERO
var food = null
var rng = RandomNumberGenerator.new()
var walkCount = 100
var debug = true
var health = 100

# NOTE : our lifetime is short so this means one baby only i guess?
var gender = FEMALE
const MAX_PREGNANCY_COOLDOWN = 100
var pregnancy_cooldown = MAX_PREGNANCY_COOLDOWN

func find_label():
	var nc = self.get_child_count()
	for i in nc:
		var c = self.get_child(i)
		if c.is_class("Label"):
			return c

	return null

func is_bear(entity):
	return entity.name.split("_")[1] == "bear"

func _physics_process(delta):
	health -= 0.05
	pregnancy_cooldown -= 1
	if debug:
		var label = find_label()
		var labels = PoolStringArray([
			"health : %s",
			"chasing food? : %s",
			"gender : %s",
			"pregnancy cooldown : %s"
		])

		var text = labels.join("\n")
		var label_str = text % [health, food != null, gender, pregnancy_cooldown]
		label.set_text(label_str)

	if food:
		velocity = position.direction_to(food.position) * run_speed
	else:
		walkCount -= 1
		if walkCount < 0:
			walkCount = 100
			velocity = Vector2(rng.randf_range(-run_speed, run_speed), rng.randf_range(-run_speed, run_speed))

	move_and_slide(velocity)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		var ent = collision.collider
		if is_bear(ent) and ent.gender != self.gender:
			# which one is the female
			var female = ent
			if female.gender != FEMALE:
				female = self

			if female.pregnancy_cooldown < 0:
				female.pregnancy_cooldown = MAX_PREGNANCY_COOLDOWN
				var game = get_parent()
				game._spawn_bear(true)

	if health <= 0:
		return self.die()
 
	var game = get_parent()
	if Global.is_outside_viewport(position):
		queue_free()
		game._spawn_bear(true)

func die():
	var game = get_parent()
	game._spawn_dead("bear", position)
	queue_free()

func _on_VisionArea_body_entered(body):
	if body.name.begins_with("prey"):
		food = body

func _on_VisionArea_body_exited(body):
	if body.name.begins_with("prey"):
		food = null

func _on_Bear_ready():
	pass
