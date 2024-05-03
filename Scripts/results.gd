extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MarginContainer/VBoxContainer/LabelMealsDelivered.text = "Meals Delivered: " + str(Global.mealsDeliveredToTeacher)
	$MarginContainer/VBoxContainer/LabelMealsLost.text = "Meals Lost to Guard: " + str(Global.mealsLostToEnemy)
# Called every frame. 'delta' is the elapsed time since the previous frame.



func _on_play_again_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_quit_pressed():
	get_tree().quit()
