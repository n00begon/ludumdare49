extends YSort

const MIN_SPAWN_INTERVAL_MS = 100
const SPAWN_VIEWPORT_BORDER_PADDING = 30

var mooseScene = load("res://life/moose.tscn")
var deerScene = load("res://life/deer.tscn")
var rabbitScene = load("res://life/rabbit.tscn")
var bearScene =  load("res://life/bear.tscn")
var foxScene =  load("res://life/fox.tscn")
var tigerScene = load("res://life/tiger.tscn")
var bushScene = load("res://life/bush.tscn")
var grassScene = load("res://life/grass.tscn")
var treeScene = load("res://life/tree.tscn")
var beaverScene = load("res://life/beaver.tscn")

var rng = RandomNumberGenerator.new()
var lastSpawnTime = 0

func _ready():
	rng.randomize()
	OS.window_fullscreen = true
	#get_node("Node2D/GameViewport").set_size(get_viewport().size - Vector2(100, -100))

func _process(delta):
	get_node("Node2D/GameViewport").set_size(get_viewport().size - Vector2(450, 100))

	# Quit on ESC
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

	_spawn(mooseScene, "ui_moose")
	_spawn(deerScene, "ui_deer")
	_spawn(rabbitScene, "ui_rabbit")
	_spawn(bearScene, "ui_bear")
	_spawn(tigerScene, "ui_tiger")
	_spawn(foxScene, "ui_fox")
	_spawn(beaverScene, "ui_beaver")

	var plant_type = rng.randi_range(1, 3)
	match plant_type:
		1:
			_spawn(bushScene, "ui_plant")
		2:
			_spawn(grassScene, "ui_plant")
		3:
			_spawn(treeScene, "ui_plant")



func _spawn(scene, actionKey):
	if not Input.is_action_pressed(actionKey):
		return
	if OS.get_ticks_msec() - lastSpawnTime < MIN_SPAWN_INTERVAL_MS:
		return

	var newObj = scene.instance()
	var viewport = get_viewport().size
	newObj.set_global_position(
		Global.gen_rnd_point()
	)
	lastSpawnTime = OS.get_ticks_msec()
	if Global.life_object_counter < Global.MAX_LIFE_OBJECTS:
		self.add_child(newObj)
		Global.life_object_counter += 1

var deadScene = load("res://dead/dead_animal.tscn")
func _spawn_dead(name, position):
	var newObj = deadScene.instance()
	var deadTextureFile = "res://assets/animals/dead/" + name + ".png"
	if not File.new().file_exists(deadTextureFile):
		return
	var texture = get_resized_texture(load(deadTextureFile), 0.25)
	newObj.set_global_position(position)
	newObj.texture = texture
	self.add_child(newObj)

func get_resized_texture(t: Texture, scale: float):
	var image = t.get_data()
	image.resize(image.get_width() * scale, image.get_height() * scale)
	var itex = ImageTexture.new()
	itex.create_from_image(image)
	return itex
