extends CenterContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func show():
	visible = true

func hide():
	visible = false

func set_score(score: int):
	$VBoxContainer/Words.text = "Your ecosystem was unstable"
	$VBoxContainer/Label.text = "Final Score: " + str(score)

func _on_RestartButton_pressed():
	get_tree().change_scene("res://Intro.tscn")
