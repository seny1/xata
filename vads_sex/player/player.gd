extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
signal vad_is_fucking_now
signal vad_stoped_his_sex

func _ready():
	anim.play("idle")

func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		if anim.animation != "fuck":
			anim.play("fuck")
			vad_is_fucking_now.emit()
	else:
		if anim.animation != "idle":
			anim.play("idle")
			vad_stoped_his_sex.emit()
