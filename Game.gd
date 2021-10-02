extends Node2D

const MIN_SPAWN_INTERVAL_MS = 100

var deerScene = load("res://MuskDeer.tscn")
var bearScene = load("res://Bear.tscn")
var rng = RandomNumberGenerator.new()

var counters = {}
var lastSpawnTime = 0

func _ready():
	OS.window_fullscreen = true

func _spawn(type, name, scene):
	var newObj = scene.instance()
	var prefix = type + "_" + name
	newObj.name = type + "_" + name +"_" + str(counters.get(prefix, 0))
	print(newObj.name)
	var viewport = get_viewport().size
	newObj.set_global_position(Vector2(rng.randi_range(0, viewport.x), rng.randi_range(0, viewport.y)))
	get_parent().add_child(newObj)
	counters[prefix] = counters.get(prefix, 0) + 1

func _spawn_deer():
	_spawn("prey", "deer", deerScene)

func _spawn_bear():
	_spawn("pred", "bear", bearScene)

func _process(delta):
	# Quit on ESC or Q
	if Input.is_action_pressed("ui_cancel") or Input.is_action_pressed("ui_quit"):
		get_tree().quit()

	if OS.get_ticks_msec() - lastSpawnTime > MIN_SPAWN_INTERVAL_MS:
		if Input.is_action_pressed("ui_deer"):
			_spawn_deer()
			lastSpawnTime = OS.get_ticks_msec()
		elif Input.is_action_pressed("ui_bear"):
			_spawn_bear()
			lastSpawnTime = OS.get_ticks_msec()
