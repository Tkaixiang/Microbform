extends Control

var queue = []

var finishedTextPressNext = false

onready var Msg = $Msg
onready var Text = $Msg/Text
onready var ContinueMsg = $Msg/ContinueMsg
onready var AnimePlayerRevealText = $Msg/AnimePlayer
onready var ContinuePlayer = $Msg/ContinuePlayer
onready var Picture = $Picture
onready var SelectOption = $SelectOption
onready var SelectOptionText = $SelectOption/Text
onready var options = [$SelectOption/Option1, $SelectOption/Option2, $SelectOption/Option3]
onready var optionsText = [$SelectOption/Option1/Label, $SelectOption/Option2/Label, $SelectOption/Option3/Label]
onready var SelectOptionAnime = $SelectOption/SelectOptionAnimation

signal allDone(type)
signal selectedOption(optionValue)

func addMsg(msg):
	queue.append(msg)

func addQuestion(msg, options):
	queue.append({"msg": msg, "options": options})

func playNext():
	ContinueMsg.visible = false
	self.visible = true
	var msg = queue[0]
	queue.remove(0)
	
	if (typeof(msg) == TYPE_STRING):
		Msg.visible = true
		SelectOption.visible = false
		Text.text = msg
		AnimePlayerRevealText.play("RevealText", -1, 1.0 / (float(len(msg))/35))
	else:
		Msg.visible = false
		for x in options:
			x.visible = false
		SelectOption.visible = true
		
		SelectOptionText.text = msg["msg"]
		for x in range(0, len(msg.options), 1):
			options[x].visible = true
			optionsText[x].text = msg["options"][x]
		SelectOptionAnime.play("DisplayMsg&Options")
	
func setPic(path, scale=Vector2(1.223, 0.902)):
	Picture.texture = load(path)
	Picture.scale = scale
		
func _ready():
	self.visible = false
	ContinueMsg.visible = false

func stopNReset():
	queue = []
	AnimePlayerRevealText.stop(true)
	SelectOptionAnime.stop(true)
	self.visible = false

func _input(event):
	if (Input.is_action_just_pressed("enter") and self.visible):
		if (not finishedTextPressNext and SelectOption.visible == false):
			AnimePlayerRevealText.seek(1.48)
		if (finishedTextPressNext and SelectOption.visible == false):
			finishedTextPressNext = false
			if (len(queue) > 0):
				playNext()
			else:
				self.visible = false
				AnimePlayerRevealText.stop(true)
				emit_signal("allDone", "msg")

func _on_AnimePlayer_animation_finished(anim_name):
	AnimePlayerRevealText.stop(true)
	finishedTextPressNext = true
	ContinueMsg.visible = true

func _on_SelectOptionAnimation_animation_finished(anim_name):
	SelectOptionAnime.stop(true)

func _on_Option1_pressed():
	selectedOption(1)

func _on_Option2_pressed():
	selectedOption(2)

func _on_Option3_pressed():
	selectedOption(3)

func selectedOption(option):
	for x in options:
		x.visible = false
	emit_signal("selectedOption", option)
