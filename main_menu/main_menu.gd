extends Control

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://vads_sex/main.tscn")
	
func _on_quit_button_pressed() -> void:
	get_tree().quit()
