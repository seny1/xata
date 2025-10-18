extends Node

@onready var player = $Player
@onready var mob = $Mob

var is_sexing = false
var player_caught = false

func _on_mob_mob_awake() -> void:
	if is_sexing:
		player_caught = true
		print("GAME OVER!")

func _on_mob_mob_sleeping() -> void:
	player_caught = false
	
func _on_player_vad_is_fucking_now() -> void:
	is_sexing = true

func _on_player_vad_stoped_his_sex() -> void:
	is_sexing = false  
