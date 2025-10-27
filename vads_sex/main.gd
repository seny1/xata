extends Node

@onready var player = $Player
@onready var mob = $Mob
@onready var music_player = $MusicPlayer
@onready var surprised_player = $SurprisedPlayer

signal game_over
signal score_changed
var is_sexing = false
var player_caught = false
var mob_sleeping = false
var score = 0

func _ready() -> void:
	start_game()

func _on_mob_mob_awake() -> void:
	mob_sleeping = false

func _on_mob_mob_sleeping() -> void:
	mob_sleeping = true
	
func _on_player_vad_is_fucking_now() -> void:
	is_sexing = true

func _on_player_vad_stoped_his_sex() -> void:
	is_sexing = false

func start_game() -> void:
	var game_over_var = get_node("/root/Main/HUDVadSex/GameOver")
	var retry_button = get_node("/root/Main/HUDVadSex/RetryButton")
	var pause_button = get_node("/root/Main/HUDVadSex/PauseButton")
	game_over_var.visible = false
	retry_button.visible = false
	pause_button.visible = true
	mob.set_state(Global.State.SLEEPING)
	get_tree().paused = false
	$ScoreTimer.start()
	score = 0
	music_player.play()
	
func restart_game() -> void:
	start_game()

func _process(_delta):
	if is_sexing and !mob_sleeping:
		game_over.emit()

func _on_score_timer_timeout() -> void:
	if is_sexing:
		score += 1
		emit_signal("score_changed", score)

func _on_hud_vad_sex_game_over_sig() -> void:
	music_player.stop()
	var choose = (randi() % 4) + 1
	if choose == 1:
		surprised_player.stream = preload("res://music/ars_surpised/ars_1.ogg")
	elif choose == 2:
		surprised_player.stream = preload("res://music/ars_surpised/ars_2.ogg")
	elif choose == 3:
		surprised_player.stream = preload("res://music/ars_surpised/ars_3.ogg")
	else:
		surprised_player.stream = preload("res://music/ars_surpised/ars_4.ogg")
	surprised_player.play()
	mob.set_state(Global.State.GAME_OVER)
