extends StaticBody2D

onready var root = get_tree().current_scene
onready var world = root.get_tree().current_scene
onready var SpeechText = self.get_node("../Player/Camera2D/SpeechText")
onready var questionNumber = 0

func _ready():
	SpeechText.connect("allDone", self, "_all_Done")
	SpeechText.connect("selectedOption", self, "selectedOption")
	# Connect signals
	# allDone is called when there is nothing left in the queue to play
	# selectedOption is called with the option number (int) when an option is pressed

func _all_Done(type):
	world.gotoScene("res://Rooms/StartingRoom.tscn")
	world.setDoorDone(0)
	world.setAnxietyMeter(0.3)

func _on_Area2D_area_entered(area):
	SpeechText.setPic("res://assets/Bush.png") 
	# Set the right side image of the textbox
	# Drag and drop the asset here to get the exact string path
	SpeechText.addMsg("Hello world!") 
	# Add a message text
	# Users can press "Enter" to skip the typing animation
	SpeechText.addMsg("Uwu, can you hear me?")
	SpeechText.addQuestion("Choose an option:", ["hello", "2", "3"])
	SpeechText.playNext()
	# Start playing
	# If the next few are all "text messages", messages will auto play after the user presses enter
	# If the message is a "question", you have to manually call playNext() 
	# after the option is selected to play the next message (See below for an example)


func _on_Area2D_area_exited(area):
	questionNumber = 0
	SpeechText.stopNReset()

func selectedOption(option):
	if (questionNumber == 0):
		if (option == 1):
			SpeechText.addMsg("You selected option 1!")
		elif (option == 2):
			SpeechText.addMsg("You selected option 2!")
		elif (option == 3):
			SpeechText.addMsg("You selected option 3!")
		questionNumber += 1
		SpeechText.addQuestion("Choose an option:", ["helloâ˜ºí ½í¸´í ½í¸´í ½í¸´í ½í¸´í ½í¸´í ½í¸´í ½í¸´í ½í¸´í ½í¸Ží ½í¸Ží ½í¸Ží ½í¸Ží ½í¸Ží ½í¸Ž"])
		world.setAnxietyMeter(0.2)
	elif (questionNumber == 1):
		if (option == 1):
			SpeechText.addMsg("You selected option 1!")
		elif (option == 2):
			SpeechText.addMsg("You selected option 2!")
		elif (option == 3):
			SpeechText.addMsg("You selected option 3!")
		questionNumber += 1
	SpeechText.playNext() # Play it manually as after a question, it does not autoplay
	
	
