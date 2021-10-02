extends YSort

const MIN_SPAWN_INTERVAL_MS = 100
const SPAWN_VIEWPORT_BORDER_PADDING = 30

var mooseScene = load("res://life/prey/prey_moose.tscn")
var deerScene = load("res://life/prey/prey_deer.tscn")
var rabbitScene = load("res://life/prey/prey_rabbit.tscn")
var bearScene = load("res://life/pred/pred_bear.tscn")
var bushScene = load("res://life/plant/plant_bush.tscn")
var grassScene = load("res://life/plant/plant_grass.tscn")
var treeScene = load("res://life/plant/plant_tree.tscn")
var rng = RandomNumberGenerator.new()

var counters = {}
var lastSpawnTime = 0

func _ready():
	OS.window_fullscreen = true

func _spawn_moose(forceSpawn):
	_spawn("prey", "mooseScene", mooseScene, "ui_moose", forceSpawn)

func _spawn_deer(forceSpawn):
	_spawn("prey", "deerScene", deerScene, "ui_deer", forceSpawn)

func _spawn_rabbit(forceSpawn):
	_spawn("prey", "rabbitScene", rabbitScene, "ui_rabbit", forceSpawn)

func _spawn_bear(forceSpawn):
	_spawn("pred", "bear", bearScene, "ui_bear", forceSpawn)

func _spawn_plant(forceSpawn):
	var plant_type = rng.randi_range(1, 3)
	match plant_type:
		1:
			_spawn("plant", "bush", bushScene, "ui_plant", forceSpawn)
		2:
			_spawn("plant", "grass", grassScene, "ui_plant", forceSpawn)
		3:
			_spawn("plant", "tree", treeScene, "ui_plant", forceSpawn)

func _spawn(type, name, scene, actionKey, forceSpawn):
	if not Input.is_action_pressed(actionKey) and not forceSpawn:
		return
	if OS.get_ticks_msec() - lastSpawnTime < MIN_SPAWN_INTERVAL_MS and not forceSpawn:
		return

	var newObj = scene.instance()
	var prefix = type + "_" + name
	newObj.name = prefix + "_" + str(counters.get(prefix, 0))
	print("Spawn: " + newObj.name)
	var viewport = get_viewport().size
	newObj.set_global_position(
		Vector2(
			rng.randi_range(SPAWN_VIEWPORT_BORDER_PADDING, viewport.x - SPAWN_VIEWPORT_BORDER_PADDING),
			rng.randi_range(SPAWN_VIEWPORT_BORDER_PADDING, viewport.y - SPAWN_VIEWPORT_BORDER_PADDING)
		)
	)
	self.add_child(newObj)
	counters[prefix] = counters.get(prefix, 0) + 1
	lastSpawnTime = OS.get_ticks_msec()

func _process(delta):
	# Quit on ESC or Q
	if Input.is_action_pressed("ui_cancel") or Input.is_action_pressed("ui_quit"):
		get_tree().quit()

	_spawn_moose(false)
	_spawn_deer(false)
	_spawn_rabbit(false)
	_spawn_bear(false)
	_spawn_plant(false)
