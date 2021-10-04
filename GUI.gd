extends MarginContainer

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

const MIN_SPAWN_INTERVAL_MS = 100
const SPAWN_VIEWPORT_BORDER_PADDING = 30

var rng = RandomNumberGenerator.new()
var lastSpawnTime = 0

func _spawn(scene, actionKey):
	if OS.get_ticks_msec() - lastSpawnTime < MIN_SPAWN_INTERVAL_MS:
		return

	var newObj = scene.instance()
	var viewport = get_viewport().size
	newObj.set_global_position(Global.gen_rnd_point())
	lastSpawnTime = OS.get_ticks_msec()
	var plant = actionKey == "ui_plant"
	
	if plant:
		if Global.plant_counter < Global.MAX_PLANT_OBJECTS:
			self.add_child(newObj)
			Global.plant_counter += 1
	else:
		if Global.animal_counter < Global.MAX_ANIMAL_OBJECTS:
			self.add_child(newObj)
			Global.animal_counter += 1
		
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
		


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_button_up():
	_spawn(bearScene, "ui_bear")


func _on_TigerButton_button_up():
	_spawn(tigerScene, "ui_tiger")

func _on_MooseButton_button_up():
	_spawn(mooseScene, "ui_moose")

func _on_DeerButton_button_up():
	_spawn(deerScene, "ui_deer")

func _on_RabbitButton_button_up():
	_spawn(rabbitScene, "ui_rabbit")

func _on_FoxButton_button_up():
	_spawn(foxScene, "ui_fox")

func _on_BeaverButton_pressed():
	_spawn(beaverScene, "ui_beaver")

func _on_PlantButton_pressed():
	rng.randomize()
	var plant_type = rng.randi_range(1, 3)
	match plant_type:
		1:
			_spawn(bushScene, "ui_plant")
		2:
			_spawn(grassScene, "ui_plant")
		3:
			_spawn(treeScene, "ui_plant")


func _on_QuitButton_button_up():
	get_tree().quit()
