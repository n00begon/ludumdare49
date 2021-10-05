extends CenterContainer

func _ready():
	OS.window_fullscreen = true

func _process(delta):
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
