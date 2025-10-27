extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
@onready var vad_moan = $MoanVad
@onready var an_moan = $MoanAn

signal vad_is_fucking_now
signal vad_stoped_his_sex

func _ready():
	anim.play("idle")

func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		if anim.animation != "fuck":
			var choose = randi() % 2 + 1
			if choose == 1:
				vad_moan.stream = preload("res://music/moans/moan_vad1.ogg")
				an_moan.stream = preload("res://music/moans/moan_an1.ogg")
			else:
				vad_moan.stream = preload("res://music/moans/moan_vad2.ogg")
				an_moan.stream = preload("res://music/moans/moan_an2.ogg")
			vad_moan.play()
			an_moan.play()
			anim.play("fuck")
			vad_is_fucking_now.emit()
	else:
		if anim.animation != "idle":
			anim.play("idle")
			vad_moan.stop()
			an_moan.stop()
			vad_stoped_his_sex.emit()
