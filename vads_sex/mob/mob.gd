extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
@onready var timer = $Timer

signal mob_awake
signal mob_sleeping
signal mob_turning

var state: Global.State = Global.State.SLEEPING

func _ready():
	randomize()
	set_state(Global.State.SLEEPING)
	start_random_timer()
 
func set_state(new_state: Global.State):
	state = new_state

	match state:
		Global.State.SLEEPING:
			anim.play("sleep")
			mob_sleeping.emit()
			print("Моб спит")
			start_random_timer()

		Global.State.TURNING:
			anim.play("turn")
			print("Моб ворочается")
			mob_turning.emit()
			timer.stop()
			timer.wait_time = 1.5
			timer.start()

		Global.State.AWAKE:
			anim.play("awake")
			print("Моб проснулся")
			mob_awake.emit()
			timer.stop()
			timer.wait_time = randf_range(3.0, 6.0)
			timer.start()
			
		Global.State.GAME_OVER:
			anim.play("game_over")


func start_random_timer():
	if state == Global.State.SLEEPING:
		var wait_time = randf_range(2.0, 5.0)
		timer.wait_time = wait_time
		timer.start()


func _on_Timer_timeout():
	match state:
		Global.State.SLEEPING:
			set_state(Global.State.TURNING)

		Global.State.TURNING:
			set_state(Global.State.AWAKE)

		Global.State.AWAKE:
			set_state(Global.State.SLEEPING)
