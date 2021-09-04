extends Node2D
onready var root = get_tree().current_scene
onready var player = $Player
onready var SpeechText = $Player/Camera2D/SpeechText
onready var STMsg = $Player/Camera2D/SpeechText/Msg
onready var doorDones = [$DoorDone, $DoorDone2, $DoorDone3]
var initState = 0
var playerName = "MCB"

var door1Area = false
var door2Area = false
var door3Area = false

var introArea = false
var introDoneState = false
var bananaDoneState = false

func _ready():
	player.movement = false
	for x in doorDones:
		x.visible = false
	SpeechText.connect("allDone", self, "_all_Done")
	SpeechText.connect("selectedOption", self, "selectedOption")
	initState = 1
	SpeechText.setPic("res://assets/Player/playerBase.png")
	SpeechText.addMsg("After a disastrous bus trip, you finally reach school.")
	SpeechText.addMsg("~This is an innocent time skip~")
	SpeechText.addMsg("Now, do you find your surroundings suspiciously familiar? ")
	SpeechText.addMsg("Indeed, this is the source of nightmare, an unholy ground filled with malicious traps and evilness lurking behind pillars, the 18th floor of purgatory.")
	SpeechText.addMsg("The Canteen.")
	SpeechText.addMsg("Perhaps you feel overwhelmed by the chaotic waves of people before your eyes, or the near-deafening sounds of noisy conversations and frequent...")
	SpeechText.addMsg("...abrupt screams. Perhaps you shrink away the eyes of strangers judging every single of your gestures. Perhaps you are too sharply aware of...")
	SpeechText.addMsg("... your lonesome figure, and are leaning towards deciding that the chocolate bar from the distant vending machine would make for a more wonderful...")
	SpeechText.addQuestion("...lunch instead.", ["Neither god nor demon shall take away my food!", "My anxiety is all in my head. I'm just buying lunch, what the heck...", "*Brain already short-circuited."])
	SpeechText.playNext()
	
func _all_Done(type):
	if (initState == 1):
		SpeechText.visible = true
		STMsg.visible = false
		initState = 2
	elif (initState == 3):
		player.movement = true
		
func selectedOption(option):
	player.movement = true
	SpeechText.stopNReset()
	# if (initState == 3):
		#SpeechText.stopNReset()
		#if (option == 1):
			#if (door1Area):
				#root.gotoScene("res://Rooms/TestScene.tscn")
			#elif (door2Area):
				#pass
			#elif (door3Area):
				#pass

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
		SpeechText.addMsg("It's my friend MCB's birthday! Join me as we are going on a trip in our favourite rocket shi- I mean, on a trip to the party!")
		SpeechText.addQuestion("Head to the party?", ["Yes", "No"])
		SpeechText.playNext()
		
func _on_Door3_area_exited(area):
	SpeechText.stopNReset()
	door3Area = false

func _on_Banana_area_entered(area):
	
	if (not bananaDoneState):		
		player.movement = false
		
		SpeechText.addMsg("Crash!")
		SpeechText.addMsg("As you are wondering why your world has suddenly turned 180 degrees, a burst of stinging pain registers in your knees.")
		SpeechText.addMsg("Congratulations on triggering the flag of one of the most embarassing incidents that can happen in a canteen, tripping over a banana peel!")
		# should probably be something like player stands up here
		SpeechText.addMsg("Almost everybody's gazes are on your body, and no, this time it is not your made-up illusion.")
		SpeechText.addMsg("As you slowly stand up, uncontrollable thoughts such as 'I want to jump into a hole right now' and 'Why am I so stupid goddamnit' pour into...")
		SpeechText.addMsg("...your mind.")
		SpeechText.addMsg("It feels as if the stares of the people around you are full of judgement and disdain for your idiocy.")
		SpeechText.addQuestion("What will you do?", ["Go into panic attack mode.", "Smile. Tripping over things is perfectly normal human behavior.", "Take a deep breath, and continue walking forward. Your stomach is still growling."])
		SpeechText.playNext()
		
		bananaDoneState = true

