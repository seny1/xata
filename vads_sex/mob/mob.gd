extends CharacterBody2D

enum State { SLEEPING, TURNING, AWAKE }

@onready var anim = $AnimatedSprite2D
@onready var timer = $Timer
signal mob_awake
signal mob_sleeping
signal mob_turning

var state: State = State.SLEEPING

func _ready():
	randomize()
	set_state(State.SLEEPING)
	start_random_timer()
 
func set_state(new_state: State):
	state = new_state

	match state:
		State.SLEEPING:
			anim.play("sleep")
			mob_sleeping.emit()
			print("Моб спит")
			start_random_timer()

		State.TURNING:
			anim.play("turn")
			print("Моб ворочается")
			mob_turning.emit()
			timer.stop()
			timer.wait_time = 1.5
			timer.start()

		State.AWAKE:
			anim.play("awake")
			print("Моб проснулся")
			mob_awake.emit()
			timer.stop()
			timer.wait_time = randf_range(3.0, 6.0)
			timer.start()


func start_random_timer():
	if state == State.SLEEPING:
		var wait_time = randf_range(2.0, 5.0)
		timer.wait_time = wait_time
		timer.start()


func _on_Timer_timeout():
	match state:
		State.SLEEPING:
			set_state(State.TURNING)

		State.TURNING:
			set_state(State.AWAKE)

		State.AWAKE:
			set_state(State.SLEEPING)
