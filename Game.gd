extends Node2D

var muskDeer = load("res://MuskDeer.tscn")
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

const MIN_SPAWN_INTERVAL_MS = 300
var lastSpawnTime = 0

func _spawn_deer():
		var newDeer = muskDeer.instance()
		var viewport = get_viewport().size
		newDeer.set_global_position(Vector2(rng.randi_range(0, viewport.x), rng.randi_range(0, viewport.y)))
		get_parent().add_child(newDeer)	

func _process(delta):
	# Quit on ESC
	if Input.is_action_pressed("ui_cancel") or Input.is_action_pressed("ui_quit"):
		get_tree().quit()

	if OS.get_ticks_msec() - lastSpawnTime > MIN_SPAWN_INTERVAL_MS:
		if Input.is_action_pressed("ui_deer"):
			_spawn_deer()
			lastSpawnTime = OS.get_ticks_msec()
