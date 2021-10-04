extends Node2D

func _ready():
	OS.window_fullscreen = true
	VisualServer.set_default_clear_color(Color(0.2,0.2,0.2,1))

func _process(delta):
	var button = get_node("Button")
	var instructions = get_node("Instructions")
	button.set_global_position(get_viewport().size / 2 - button.rect_size / 2)
	instructions.set_global_position(get_viewport().size / 2 - instructions.rect_size / 2 - Vector2(0, button.rect_size.y))
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _on_Button_pressed():
	get_tree().change_scene("res://Game.tscn")
