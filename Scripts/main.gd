extends Node2D

func _on_energy_bar_value_changed(value: float) -> void:
	if value == 0:
		get_tree().change_scene_to_file("res://Scenes/m_menu.tscn")
