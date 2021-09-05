extends Control

onready var Meter = $Meter
onready var animePlayer = $AnimationPlayer
onready var nopanic = $panicImage/nopanic
onready var mildpanic = $panicImage/mildpanic
onready var panic = $panicImage/panic
const MAX_LENGTH = 180
const MIN_LENGTH = 5

func _ready():
	nopanic.visible = false
	mildpanic.visible = false
	panic.visible = false

# Level is a float value between 0 to 1
func setAnxietyLevel(level, play=false):
	Meter.rect_size = Vector2((MAX_LENGTH-MIN_LENGTH) * level, 31.0)
	Meter.color = Color8(int(level * 255.0), 136 - (level * 136), 12, 255)
	if (level < 0.30):
		nopanic.visible = true
		mildpanic.visible = false
		panic.visible = false
	elif (level >= 0.3 and level < 0.6):
		nopanic.visible = false
		mildpanic.visible = true
		panic.visible = false
	elif (level >= 0.6):
		nopanic.visible = false
		mildpanic.visible = false
		panic.visible = true
	if (play):
		animePlayer.play("FloatUp")

func _on_AnimationPlayer_animation_finished(anim_name):
	animePlayer.stop(true)
