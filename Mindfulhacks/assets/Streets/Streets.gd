extends Node2D

var progress = 0
var tryByYourself = false
var askStranger = false
onready var SpeechText = $Player/Camera2D/SpeechText
onready var Player = $Player
onready var WP1 = $Waypoint1
onready var WP2 = $Waypoint2
onready var WP3 = $Waypoint3
onready var WP4 = $Waypoint4
onready var StrangerHarass = $StrangerHarrassingYou
onready var StrangerHarassAnime = $StrangerHarrassingYou/StrangerPlayer
onready var root = get_tree().current_scene

func _ready():
	WP2.visible = false
	WP3.visible = false
	WP4.visible = false
	StrangerHarass.visible = false
	SpeechText.connect("allDone", self, "_all_Done")
	SpeechText.connect("selectedOption", self, "selectedOption")
	Player.movement = false
	SpeechText.setPic("res://assets/Player/playerBase.png")
	SpeechText.addMsg("According to the directions MCB sent...the party should be right ahead...")
	SpeechText.addMsg("Maybe...")
	SpeechText.addMsg("Don't worry " + root.playerName + "! You can do this. Just. Follow. The. Directions. Given.")
	SpeechText.addMsg("(*Head to the yellow waypoint ahead*)")
	SpeechText.playNext()
	progress = 1

func _all_Done(type):
	if (progress == 1):
		Player.movement = true
		progress = 2 
	elif (progress == 3):
		Player.movement = true
		progress = 4
		WP2.visible = true
	elif (progress == 6 and tryByYourself):
		Player.movement = true
		WP3.visible = true
	elif progress == 8:
		Player.movement = true
		WP4.visible = true
	elif progress == 10:
		root.setAnxietyMeter(root.anxietyMeter + 0.05, true)
		SpeechText.setPic("res://Rooms/mcb_panic.png")
		SpeechText.addMsg(root.playerName + ": H-help?")
		SpeechText.playNext()
		progress = 11
	elif progress == 11:
		SpeechText.setPic("res://assets/Streets/character2.png")
		SpeechText.addMsg("Stranger: Yes please! May I ask if you know where is Gedong View Plaza?")
		SpeechText.addQuestion("How do you respond?", ["Sorry I am in a rush!", "Sure, let me check my phone's Google Maps!", "Let me check this foldable map I have in my bag!"])
		progress = 12
		SpeechText.playNext()
	elif progress == 13:
		root.setAnxietyMeter(root.anxietyMeter + 0.05, true)
		SpeechText.setPic("res://assets/Streets/phone.png", Vector2(0.085, 0.067))
		SpeechText.addMsg("*You take out your phone to search*")
		SpeechText.addQuestion("What do you search?", ["Gedong View Plaza", "Gedong Sungei Plaza", "Gedong Gedong Plaza"])
		SpeechText.playNext()
		progress = 14
	elif progress == 15:
		StrangerHarassAnime.play("walkAway")
		SpeechText.setPic("res://Rooms/mcb_panic.png")
		SpeechText.addMsg("Wait... did I give the stranger the correct address...?")
		SpeechText.addQuestion("Did you give the correct address?", ["M-maybe", "I think so??", "OH SHIT I DIDN'T PANIC MODE"])
		SpeechText.playNext()
		progress = 16
	elif progress == 17:
		root.gotoScene("res://Rooms/StartingRoom.tscn")
		root.setDoorDone(2)
		
func _on_Waypoint1_area_entered(area):
	if (progress == 2):
		progress = 3
		Player.movement = false
		WP1.visible = false
		root.setAnxietyMeter(root.anxietyMeter + 0.05, true)
		SpeechText.setPic("res://Rooms/mcb_mildpanic.png")
		SpeechText.addMsg("Hmmm... it isn't here...")
		SpeechText.addMsg("Maybe it is across the street? The house numbers here don't seem right...")
		SpeechText.addMsg("(*Head to the yellow waypoint across the street*)")
		SpeechText.playNext()

func selectedOption(option):
	if (progress == 5):
		if (option == 1):
			SpeechText.setPic("res://assets/Streets/phone.png", Vector2(0.085, 0.067))
			SpeechText.addMsg("You decided to call your friend")
			SpeechText.addMsg("Just then... your phone rings")
			SpeechText.addMsg("MCB Over the Phone: " + root.playerName + " WHERE ARE YOUUUUU!!")
			SpeechText.addMsg("*You get embarrssed and try to come up with an excuse")
			SpeechText.addQuestion("Choose an excuse:", ["I had a stomache", "My bus broke down", "I ran into sentient AIs created by Elon Musk"])
			progress = 7
		elif (option == 2):
			SpeechText.addMsg("You decide to try and find your way around")
			SpeechText.addMsg("(*Head to the yellow waypoint to the left*)")
			tryByYourself = true
			progress = 6
		elif (option == 3):
			SpeechText.addMsg("You decide to try and ask a stranger")
			SpeechText.addMsg("(*Head to the yellow waypoint to the left*)")
			tryByYourself = true
			askStranger = true
			progress = 6
		SpeechText.playNext()
	elif (progress == 7):
		root.setAnxietyMeter(root.anxietyMeter + 0.05, true)
		SpeechText.addMsg("MCB Over the Phone: Oh coming up with one of your lame excuses again? Seriously?")
		SpeechText.addMsg(root.playerName + ": I-I am lost")
		SpeechText.addMsg("MCB Over the Phone: Oh again? Why didn't you call sooner? Here's the directions")
		SpeechText.addMsg("*MCB repeats the directions and you thank MCB for helping you*")
		SpeechText.addMsg("(*Head to the yellow arrow point on the left*)")
		SpeechText.playNext()
		progress = 8
	elif (progress == 12):
		if (option == 1):
			SpeechText.setPic("res://assets/Streets/character2.png")
			SpeechText.addMsg("Stranger: Please! There isn't really anyone else around here.")
			SpeechText.addMsg("*You feel embarrassed and agree to help her*")
		elif (option == 2):
			SpeechText.addMsg("Stranger: Thank you so much!")
			SpeechText.addMsg("*You feel a sense of anxiety as you whip out your phone*")
		elif (option == 3):
			SpeechText.setPic("res://Rooms/mcb_panic.png")
			SpeechText.addMsg("You realise no one uses foldable maps anymore and apologise before taking out your phone instead")
		SpeechText.playNext()
		progress = 13
	elif progress == 14:
		SpeechText.setPic("res://assets/Streets/character2.png")
		SpeechText.addMsg("*After an awkardly long amount of time, you give the directions to the stranger*")
		SpeechText.addMsg("Stranger: thank you so much!")
		SpeechText.playNext()
		progress = 15
	elif progress == 16:
		root.setAnxietyMeter(root.anxietyMeter + 0.05, true)
		SpeechText.addMsg("You decide to hurry off to the party as you are really running late...")
		SpeechText.addMsg("Your anxiety has reached a peak... leading to the physical manifestation of the stranger haunting you for giving the wrong directions")
		SpeechText.playNext()
		progress = 17

func _on_Waypoint2_area_entered(area):
	if (progress == 4):
		progress = 5
		WP2.visible = false
		Player.movement = false
		root.setAnxietyMeter(root.anxietyMeter + 0.05, true)
		SpeechText.setPic("res://Rooms/mcb_panic.png")
		SpeechText.addMsg("Ahhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh")
		SpeechText.addMsg("I seem to be really lost!")
		SpeechText.addMsg("Should I call my friend for help? But this is soooooooooooooooooo embarrassing!")
		SpeechText.addMsg("MCB gave some really detailed directions in the whatsapp chat and it seems like most of my friends have already found their way there!")
		SpeechText.addQuestion("What should I do?", ["Call friend for help", "Continue trying", "Ask a stranger for help"])
		SpeechText.playNext()

func _on_Waypoint3_area_entered(area):
	if (progress == 6 and tryByYourself):
		WP3.visible = false
		Player.movement = false
		SpeechText.setPic("res://assets/Streets/phone.png", Vector2(0.085, 0.067))
		if (askStranger):
			SpeechText.addMsg("Just as you are to approach the stranger, your veins freeze in place as the thought of speaking to someone dawns upon you...")
		SpeechText.addMsg("Just then... your phone rings")
		SpeechText.addMsg("*You answer the phone*")
		SpeechText.addMsg("MCB Over the Phone: " + root.playerName + " WHERE ARE YOUUUUU!! You are LATE with a big fat L")
		SpeechText.addMsg("*You get embarrssed and try to come up with an excuse*")
		SpeechText.addQuestion("Choose an excuse:", ["I had a stomache", "My bus broke down", "I ran into sentient AIs created by Elon Musk"])		
		SpeechText.playNext()
		progress = 7

func _on_Waypoint4_area_entered(area):
	if (progress == 8):
		WP4.visible = false
		Player.movement = false
		progress = 9
		StrangerHarass.visible = true
		StrangerHarassAnime.play("walkTowards")

func _on_StrangerPlayer_animation_finished(anim_name):
	
	if (anim_name == "walkTowards"):
		SpeechText.setPic("res://assets/Streets/character2.png")
		SpeechText.addMsg("Stranger: Hold up please! I need help!")
		SpeechText.addMsg("*You freeze in terror as someone calls out to you*")
		progress = 10
		SpeechText.playNext()
	elif (anim_name == "walkAway"):
		StrangerHarass.visible = false
	
