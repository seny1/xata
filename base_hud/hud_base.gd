extends CanvasLayer

@onready var paused = $Paused
@onready var click_sound = $ClickPlayer

func _ready() -> void:
	paused.visible = false

func _on_pause_button_pressed() -> void:
	click_sound.play()
	if get_tree().paused == false:
		get_tree().paused = true
		paused.visible = true
	else:
		get_tree().paused = false
		paused.visible = false

func _on_back_button_pressed() -> void:
	click_sound.play()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")
