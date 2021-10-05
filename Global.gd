extends Node
var debug = false
var rng = RandomNumberGenerator.new()
var sandbox = false;

func is_outside_viewport(pos):
	var viewport
	if get_parent().get_node("Game") != null:
		viewport = get_parent().get_node("Game").get_node("Node2D").get_node("GameViewport")
	else:
		viewport = get_parent().get_node("StableGame").get_node("Node2D").get_node("GameViewport")
	var topLeft = viewport.rect_global_position
	var bottomRight = topLeft + viewport.rect_size * viewport.rect_scale
	return pos.x < topLeft.x || pos.y < topLeft.y || pos.x > bottomRight.x || pos.y > bottomRight.y

func gen_rnd_point():
	rng.randomize()
	var viewport
	if get_parent().get_node("Game") != null:
		viewport = get_parent().get_node("Game").get_node("Node2D").get_node("GameViewport")
	else:
		viewport = get_parent().get_node("StableGame").get_node("Node2D").get_node("GameViewport")
	var topLeft = viewport.rect_global_position
	var bottomRight = topLeft + viewport.rect_size * viewport.rect_scale
	return Vector2(rng.randf_range(topLeft.x, bottomRight.x), rng.randf_range(topLeft.y, bottomRight.y))

var animal_counter = 0
var plant_counter = 0
const MAX_ANIMAL_OBJECTS = 50
const MAX_PLANT_OBJECTS = 100
