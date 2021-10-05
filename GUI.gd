extends MarginContainer

signal spawn_life(type)

func get_resized_texture(t: Texture, scale: float):
	var image = t.get_data()
	image.resize(image.get_width() * scale, image.get_height() * scale)
	var itex = ImageTexture.new()
	itex.create_from_image(image)
	return itex

func set_score(score: int):
	$VBoxContainer/HLabelContainer/VLabelContainer/ScoreLabel.text = "Score " + str(score)

func set_clicks(clicks: int):
	$VBoxContainer/HLabelContainer/VLabelContainer/InstructionLabel.text = "Clicks " + str(clicks)

func hide_labels():
	$VBoxContainer/HLabelContainer/VLabelContainer/ScoreLabel.visible = false
	$VBoxContainer/HLabelContainer/VLabelContainer/InstructionLabel.visible = false

func show_labels():
	$VBoxContainer/HLabelContainer/VLabelContainer/ScoreLabel.visible = true
	$VBoxContainer/HLabelContainer/VLabelContainer/InstructionLabel.visible = true
	
func _on_Button_button_up():
	emit_signal("spawn_life", "ui_bear")

func _on_TigerButton_button_up():
	emit_signal("spawn_life", "ui_tiger")

func _on_MooseButton_button_up():
	emit_signal("spawn_life", "ui_moose")

func _on_DeerButton_button_up():
	emit_signal("spawn_life", "ui_deer")

func _on_RabbitButton_button_up():
	emit_signal("spawn_life", "ui_rabbit")

func _on_FoxButton_button_up():
	emit_signal("spawn_life", "ui_fox")

func _on_BeaverButton_pressed():
	emit_signal("spawn_life", "ui_beaver")

func _on_PlantButton_pressed():
	emit_signal("spawn_life", "ui_plant")



func _on_QuitButton_button_up():
	get_tree().quit()

