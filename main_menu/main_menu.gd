extends Control

func _on_play_button_pressed() -> void:
	$ClickPlayer.play()
	get_tree().change_scene_to_file("res://vads_sex/main.tscn")
	
func _on_quit_button_pressed() -> void:
	$ClickPlayer.play()
	get_tree().quit()


func _on_options_button_pressed() -> void:
	$ClickPlayer.play()
