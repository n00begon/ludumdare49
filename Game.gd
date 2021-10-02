extends YSort

const MIN_SPAWN_INTERVAL_MS = 100
const SPAWN_VIEWPORT_BORDER_PADDING = 30

var deerScene = load("res://MuskDeer.tscn")
var bearScene = load("res://Bear.tscn")
var bushScene = load("res://Bush.tscn")
var rng = RandomNumberGenerator.new()

var counters = {}
var lastSpawnTime = 0

func _ready():
	OS.window_fullscreen = true

func _spawn_deer(forceSpawn):
	_spawn("prey", "deer", deerScene, "ui_deer", forceSpawn)

func _spawn_bear(forceSpawn):
	_spawn("pred", "bear", bearScene, "ui_bear", forceSpawn)

func _spawn_bush(forceSpawn):
	_spawn("plant", "bush", bushScene, "ui_bush", forceSpawn)

func _spawn(type, name, scene, actionKey, forceSpawn):
	if not Input.is_action_pressed(actionKey) and not forceSpawn:
		return
	if OS.get_ticks_msec() - lastSpawnTime < MIN_SPAWN_INTERVAL_MS and not forceSpawn:
		return

	var newObj = scene.instance()
	if type == 'plant':
		newObj.get_node("Sprite").texture = load("res://assets/plants/" + str(rng.randi() % 5 + 1) + ".png")
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

	_spawn_deer(false)
	_spawn_bear(false)
	_spawn_bush(false)
