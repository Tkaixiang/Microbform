extends Node2D

onready var root = get_tree().current_scene
onready var player = $Player
onready var SpeechText = $Player/Camera2D/SpeechText
onready var enterName = $Player/Camera2D/SpeechText/EnterName
onready var STMsg = $Player/Camera2D/SpeechText/Msg
onready var tooShort = $Player/Camera2D/SpeechText/EnterName/NameTooShort
onready var lineEdit = $Player/Camera2D/SpeechText/EnterName/LineEdit
onready var doorDones = [$DoorDone, $DoorDone2, $DoorDone3]
var initState = 0
var playerName = "MCB"

var door1Area = false
var door2Area = false
var door3Area = false

func _ready():
	player.movement = false
	for x in doorDones:
		x.visible = false
	SpeechText.connect("allDone", self, "_all_Done")
	SpeechText.connect("selectedOption", self, "selectedOption")
	enterName.visible = false
	tooShort.visible = false
	initState = 1
	SpeechText.setPic("res://assets/Player/playerBase.png")
	SpeechText.addMsg("Gee, it's such a great day today!")
	SpeechText.addMsg("Nothing could possibly go wrong today, the day's gonna be *amazing*!")
	SpeechText.addMsg("Im off to a great start!!! For I am the great...")
	SpeechText.playNext()
	
func _all_Done(type):
	if (initState == 1):
		SpeechText.visible = true
		enterName.visible = true
		STMsg.visible = false
		lineEdit.grab_focus()
		initState = 2
	elif (initState == 3):
		player.movement = true
		
func selectedOption(option):
	
	if (initState == 3):
		SpeechText.stopNReset()
		if (option == 1):
			if (door1Area):
				root.gotoScene("res://Rooms/Bus.tscn")
			elif (door2Area):
				root.gotoScene("res://Rooms/Canteen.tscn")
			elif (door3Area):
				root.gotoScene("res://Rooms/Streets.tscn")

func setDoorDone(number):
	doorDones[number].visible = true
		
func _on_Door1_area_entered(area):
	door1Area = true
	if (not root.doorDoneState[0]):
		SpeechText.addMsg("Ah, it's time to take the bus to school before I am late! Gas gas gas ")
		SpeechText.addQuestion("Take the bus?", ["Yes", "No"])
		SpeechText.playNext()
func _on_Door1_area_exited(area):
	SpeechText.stopNReset()
	door1Area = false

func _on_Door2_area_entered(area):
	door2Area = true
	
	if (not root.doorDoneState[1]):
		SpeechText.addMsg("The business, social and economical capital of this civilisation. Where everything goes down.")
		SpeechText.addQuestion("Head to the canteen?", ["Yes", "No"])
		SpeechText.playNext()
func _on_Door2_area_exited(area):
	SpeechText.stopNReset()
	door2Area = false

func _on_Door3_area_entered(area):
	door3Area = true
	
	if (not root.doorDoneState[2]):
		SpeechText.addMsg("It's my friend MCB's birthday! Let's head to the party!")
		SpeechText.addQuestion("Head to the party?", ["Yes", "No"])
		SpeechText.playNext()
func _on_Door3_area_exited(area):
	SpeechText.stopNReset()
	door3Area = false

func _on_LineEdit_text_entered(new_text):
	if (initState == 2):
		if (len(new_text) < 1):
			tooShort.visible = true
		else:
			tooShort.visible = false
			enterName.visible = false
			playerName = new_text
			root.playerName = new_text
			
			SpeechText.addMsg("For I am the great " + root.playerName + "!")
			SpeechText.addMsg("Now let's go! I have a list of things I need to finish by today.")
			SpeechText.playNext()
			initState = 3


