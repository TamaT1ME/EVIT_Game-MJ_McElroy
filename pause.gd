extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

func showPauseMenu():
	show()

func hidePauseMenu():
	hide()

func _on_resume_pressed():
	hidePauseMenu()

func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://m_menu.tscn")
