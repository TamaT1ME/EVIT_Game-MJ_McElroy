extends Control
var gamePaused: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	Global.gamePauseUpdate.connect(func(value): visible = value)

func _on_resume_pressed():
	Global.togglePause()
	
func _on_button_2_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/m_menu.tscn")

func _on_reset_button_down() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
