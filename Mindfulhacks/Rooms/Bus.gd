extends Node2D

onready var root = get_tree().current_scene
onready var SpeechText = root.find_node("SpeechText", true, false)
onready var questionNumber = 0
onready var tapCount = 0  # tap count 
onready var timer = get_node("CardReaderTimer")
onready var anxietyLevel = root.get("anxietyMeter")
onready var player = $Player


### TODO: NEED TO INCREMENT ANXIETY METER VALUE IN ROOM EXIT SEQUENCE 

func _ready():
	SpeechText.connect("allDone", self, "_all_Done")
	SpeechText.connect("selectedOption", self, "selectedOption")
	# Connect signals
	# allDone is called when there is nothing left in the queue to play
	# selectedOption is called with the option number (int) when an option is pressed

func _all_Done(type):
	print("Done")

func _on_CardReader_area_entered(area):
	# Sets the textbox image
	# Drag and drop the asset here to get the exact string path  
	
	if root.doorDoneState[0] == false: 
	# Start of interaction with card reader 
		player.movement = false
		scene_1() 
		SpeechText.playNext()
	

func _on_CardReader_area_exited(area):
	questionNumber = 0 # Player progress should be saved hopefully 
	SpeechText.stopNReset()

func selectedOption(option):
	if questionNumber == 1: 
		if option == 1: 
			scene_2()
		elif option == 2: 
			scene_3() 
		elif option == 3: 
			scene_4()
	
	elif questionNumber == 2: 
		if option == 1: 
			scene_3()
		elif option == 2: 
			scene_4()
		
	elif questionNumber == 3: 
		if option == 1: 
			scene_2() 
		elif option == 2: 
			scene_4() 
	
	elif questionNumber == 4: 
		if option == 1: 
			scene_5() 
		elif option == 2: 
			scene_6() 
	
	elif questionNumber == 5: 
		if option == 1: 
			scene_7() 
		elif option == 2: 
			scene_6() 
		
	elif questionNumber == 6: 
		if option == 1: 
			scene_8() 
	
	elif questionNumber == 7: 
		if option == 1: 
			scene_6() 
	
	elif questionNumber == 8: 
		if option == 1: 
			scene_9() 
		elif option == 2: 
			scene_10() 
	
	elif questionNumber == 9: 
		if option == 1: 
			scene_14() 
		elif option == 2: 
			scene_10()
	
	elif questionNumber == 10: 
		if option == 1: 
			scene_11() 
	
	elif questionNumber == 11: 
		if option == 1: 
			scene_12() 
	
	elif questionNumber == 12: 
		if option == 1: 
			scene_13() 
	
	elif questionNumber == 13: 
		print("nothing here")
	
	elif questionNumber == 14: 
		if option == 1: 
			scene_15() 
		elif option == 2: 
			scene_10() 
	
	elif questionNumber == 15: 
		if option == 1: 
			scene_16() 
	
	elif questionNumber == 16: 
		if option == 1: 
			scene_17() 
	
	elif questionNumber == 17: 
		if option == 1: 
			scene_17() 
		elif option == 2: 
			scene_18() 
	
	elif questionNumber == 18: 
		print("nothing here")
	
	SpeechText.playNext() # Play it manually as after a question, it does not autoplay


# Creating functions for each scene because it's too confusing uwu 
func scene_1(): 
	questionNumber = 1
	SpeechText.setPic("res://assets/Bus/wallet_missing.png")
	root.setAnxietyMeter(anxietyLevel + 0.1, true)
	SpeechText.addQuestion("You're on a bus! Time to pull out your wallet", ["Check left pocket", "Check right pocket", "Check bag"])

func scene_2(): 
	questionNumber = 2
	SpeechText.addQuestion("Crabsticks! It's not there.", ["Check right pocket", "Check bag"])

func scene_3(): 
	questionNumber = 3
	SpeechText.addQuestion("Blast! It's not there.", ["Check left pocket", "Check bag"])
	
func scene_4(): 
	questionNumber = 4
	SpeechText.addQuestion("Oh no, you've probably left it in your bag...Where in your bag is it?!", ["Check front compartment", "Check back compartment"])
	
func scene_5(): 
	questionNumber = 5
	SpeechText.addMsg("Tissues and a back-up $50 note for emergencies...")
	SpeechText.addQuestion("Maybe you could pay with that. It's an emergency, right?", ["Pay with $50 note", "Check back compartment"])

func scene_6(): 
	questionNumber = 6
	SpeechText.setPic("res://assets/Bus/wallet_found.png")
	SpeechText.addMsg("You've found your wallet! You pull it out with a sigh of relief.")
	SpeechText.addQuestion("Now, better get tapping.", ["Tap wallet against scanner"])

func scene_7(): 
	questionNumber = 7
	SpeechText.addQuestion("Money doesn't grow on trees! Hang on to your money.", ["Check back compartment"])

func scene_8(): 
	questionNumber = 8
	root.setAnxietyMeter(anxietyLevel + 0.1, true)
	SpeechText.addQuestion("BUZZ. Invalid card.", ["Try again, but press harder this time", "Take EZ-link card out"])
	SpeechText.setPic("res://assets/Bus/nay.png")
	start_timer()
	
func scene_9(): 
	questionNumber = 9
	SpeechText.addQuestion("Mmm...still nothing...", ["Tap card again, but this time at an angle", "Take EZ-link card out"])
	SpeechText.setPic("res://assets/Bus/nay.png")
	start_timer()

func scene_10(): 
	questionNumber = 10
	SpeechText.addQuestion("...", ["Pull card"])

func scene_11(): 
	questionNumber = 11
	SpeechText.addQuestion("Crap, it's stuck!", ["Keep pulling"])

func scene_12(): 
	questionNumber = 12
	SpeechText.addQuestion("...", ["Maybe try shifting it from side to side?"])

func scene_13(): 
	questionNumber = 13
	SpeechText.setPic("res://assets/Bus/yay.png")
	SpeechText.addMsg("It's out! You tap your wallet against the card reader and it flashes the card value screen of success.")

	root.setAnxietyMeter(anxietyLevel + 0.1, true)
	player.movement = true
	
func scene_14(): 
	questionNumber = 14
	SpeechText.addQuestion("Still nope.", ["Keep tapping", "Take EZ-link card out"])
	SpeechText.setPic("res://assets/Bus/nay.png")
	start_timer()

func scene_15(): 
	questionNumber = 15
	SpeechText.addQuestion("ArghhHHHHHHHh.", ["There's no going back. Tap card."])
	SpeechText.setPic("res://assets/Bus/nay.png")
	start_timer()

func scene_16(): 
	questionNumber = 16
	SpeechText.addQuestion("...", ["Tap card."])
	SpeechText.setPic("res://assets/Bus/nay.png")
	start_timer()

func scene_17(): 
	questionNumber = 17
	tapCount += 1  
	if tapCount < 3: 
		SpeechText.addQuestion("...", ["Tap card."])
	else: 
		SpeechText.addQuestion("...", ["Tap card.", "TAP. CARD."])
	SpeechText.setPic("res://assets/Bus/nay.png")
	start_timer()

func scene_18(): 
	questionNumber = 18
	SpeechText.setPic("res://assets/Bus/yay.png")
	SpeechText.addMsg("OH THANK THE HEAVENS. The sweet beep of success...")
	
	root.setAnxietyMeter(anxietyLevel + 0.1, true)
	player.movement = true


func start_timer(): 
	timer.connect("timeout",self,"_on_timer_timeout") 
	#timeout is what says in docs, in signals
	#self is who respond to the callback
	#_on_timer_timeout is the callback, can have any name
	timer.set_wait_time(1)
	timer.start() #to start

func _on_timer_timeout():
	SpeechText.setPic("res://assets/Bus/okay.png")
	timer.stop() 

# Bus exit 
func _on_right_area_entered(area):
	root.gotoScene("res://Rooms/BusOut.tscn")
