extends "res://base_hud/hud_base.gd"

@onready var game_over = $GameOver
@onready var retry_button = $RetryButton
@onready var pause_button = $PauseButton
@onready var score_label = $ScoreLabel
@onready var game_over_player = $GameOverPlayer

signal game_over_sig

func _ready() -> void:
	game_over.visible = false
	retry_button.visible = false

func _on_node_game_over() -> void:
	game_over_player.play()
	game_over.visible = true
	retry_button.visible = true
	pause_button.visible = false
	get_tree().paused = true
	game_over_sig.emit()
	
func _on_retry_button_pressed() -> void:
	click_sound.play()
	var main = get_node("/root/Main")
	main.restart_game()
	score_label.text = "0"
	
func _on_main_score_changed(new_score) -> void:
	score_label.text = str(new_score)
