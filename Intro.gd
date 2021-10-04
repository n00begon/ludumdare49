extends Node2D

func _ready():
	OS.window_fullscreen = true
	#VisualServer.set_default_clear_color(Color(0.2,0.2,0.2,1))

func _process(delta):
	var stable_button = get_node("Stable")
	var sandbox_button = get_node("Sandbox")
	var instructions = get_node("Instructions")
	stable_button.set_global_position(get_viewport().size / 2 - stable_button.rect_size / 2)
	instructions.set_global_position(get_viewport().size / 2 - instructions.rect_size / 2 - Vector2(0, stable_button.rect_size.y))
	sandbox_button.set_global_position(get_viewport().size / 2 - stable_button.rect_size / 2 + Vector2(0, stable_button.rect_size.y))
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _on_Stable_pressed():
	Global.sandbox = false
	print("Starting Stable")
	get_tree().change_scene("res://Game.tscn")

func _on_Sandbox_pressed():
	Global.sandbox = true
	print("Starting Sandbox")
	get_tree().change_scene("res://Game.tscn")
