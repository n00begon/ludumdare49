extends YSort

const MIN_SPAWN_INTERVAL_MS = 100
const SPAWN_VIEWPORT_BORDER_PADDING = 30
const MAX_CLICKS = 5

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
var deadScene = load("res://dead/dead_animal.tscn")
var generation_counter = {
	"moose": 0, 
	"deer": 0, 
	"rabbit": 0, 
	"bear": 0, 
	"fox": 0, 
	"tiger": 0,
	"beaver": 0 
}
	

var rng = RandomNumberGenerator.new()
var lastSpawnTime = 0
var clicks_remaining = MAX_CLICKS

func _ready():
	VisualServer.set_default_clear_color(Color(0.27451, 0.537255, 0.231373, 1))
	rng.randomize()
	OS.window_fullscreen = true
	get_node("GuiContainer").connect("spawn_life", self, "_spawn_signal")
	if !Global.sandbox:
		_spawn_starting_objects()
		$GuiContainer.show_labels()
	else:
		$GuiContainer.hide_labels()
	
	#get_node("Node2D/GameViewport").set_size(get_viewport().size - Vector2(100, -100))

func _process(delta):
	get_node("Node2D/GameViewport").set_size(get_viewport().size - Vector2(450, 100))

	# Quit on ESC
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _spawn_signal(type: String):
	if !Global.sandbox && clicks_remaining <= 0:
		return
	
	clicks_remaining -= 1
	$GuiContainer.set_clicks(clicks_remaining)
	
	match type:
		"ui_moose":
			_spawn(mooseScene, "ui_moose", 2)
		"ui_deer":
			_spawn(deerScene, "ui_deer", 3)
		"ui_rabbit":
			_spawn(rabbitScene, "ui_rabbit", 5)
		"ui_bear":
			_spawn(bearScene, "ui_bear", 2)
		"ui_tiger":
			_spawn(tigerScene, "ui_tiger", 1)
		"ui_fox":
			_spawn(foxScene, "ui_fox", 2)
		"ui_beaver":
			_spawn(beaverScene, "ui_beaver", 4)
		"ui_plant":
			var plant_type = rng.randi_range(1, 3)
			match plant_type:
				1:
					_spawn(bushScene, "ui_plant", 3)
				2:
					_spawn(grassScene, "ui_plant", 6)
				3:
					_spawn(treeScene, "ui_plant", 2)

func _spawn_starting_objects():
	for b in 3:
		_spawn_life(bushScene, true)

	for g in 5:
		_spawn_life(grassScene, true)

	for t in 2:
		_spawn_life(treeScene, true)
	update_score()
	$GuiContainer.set_clicks(clicks_remaining)

func _spawn(scene, actionKey, amount):
	if OS.get_ticks_msec() - lastSpawnTime < MIN_SPAWN_INTERVAL_MS:
		return

	lastSpawnTime = OS.get_ticks_msec()

	if Global.sandbox:
		_spawn_life(scene, actionKey == "ui_plant")
	else:
		for i in amount:
			_spawn_life(scene, actionKey == "ui_plant")

func _spawn_life(scene: PackedScene, plant: bool):
	var newObj = scene.instance()
	var viewport = get_viewport().size
	newObj.set_global_position(
		Global.gen_rnd_point()
	)
	newObj.connect("new_spawn", self, "update_generation_count")
	if plant:
		if Global.plant_counter < Global.MAX_PLANT_OBJECTS:
			self.add_child(newObj)
			Global.plant_counter += 1
	else:
		if Global.animal_counter < Global.MAX_ANIMAL_OBJECTS:
			self.add_child(newObj)
			Global.animal_counter += 1

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
	
func update_generation_count(species: String, generation: int):
	printt("Updating generation count", species, generation)
	if generation_counter[species] < generation:
		generation_counter[species] = generation
		update_score()
		
func update_score():
	var total = 0
	for score in Array(generation_counter.values()):
		total += score
	$GuiContainer.set_score(total)
