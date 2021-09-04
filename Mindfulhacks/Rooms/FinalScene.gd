extends Node2D

onready var player = $Player
onready var SpeechText = $Player/Camera2D/SpeechText
onready var AnxietyMeter = $Player/Camera2D/AnxietyMeter
onready var world = get_node("/root/World")
var progress = 0

func _ready():
	SpeechText.connect("allDone", self, "_all_Done")
	SpeechText.connect("selectedOption", self, "selectedOption")
	player.movement = false
	SpeechText.setPic("res://Rooms/mcb_panic.png")
	SpeechText.addMsg("Why??? Why are so many terrible things happening to me today???")
	SpeechText.addMsg("I must have the worst luck in the world. I was so embarrassing in front of the bus driver...and in the canteen...and I probably gave someone the wrong directions!!")
	SpeechText.addMsg("I’m never going to live today down. I’m going to carry this panic to the grave. Actually, I might as well just dig a hole in the ground now and bury myself alive. Time for an eternal nap…")
	SpeechText.playNext()
	progress = 1
	
func _all_Done(type):
	if (progress == 1):
		player.activateGhosts("Bus")
		SpeechText.addMsg(world.playerName + ": woah--!? You! You’ve been following me this whole time, right? ")
		SpeechText.addMsg("Driver: yeah, because you couldn’t stop feeling guilty about your bus trip.")
		SpeechText.addMsg(world.playerName + ": Of course not! Remember when I tried to tap in?")
		SpeechText.addQuestion("Your response:", ["I must be the only person who doesn’t have my bus card ready before I board!"], ["Actually...it’s not that bad. There wasn’t anyone behind me, so I wasn’t holding anyone back."])
		SpeechText.playNext()
		progress = 2
	elif (progress == 3):
		SpeechText.setPic("res://Rooms/mcb_mildpanic.png")
		SpeechText.addMsg(world.playerName + ": whew, actually, I guess there’s really nothing to be scared about. Those things could’ve happened to anyone.")
		SpeechText.playNext()
		progress == 4
	elif (progress == 4):
		player.deactiveGhosts("Bus")
		player.activateGhosts("Canteen")
		SpeechText.addMsg(world.playerName + ": I smell...noodles? Ah!! Noodles!! I just spilled that on myself today!!")
		SpeechText.addMsg("Cook: woah, you’re still thinking about that?")
		SpeechText.addMsg(world.playerName + ": you! You’ve been following me around as well!?")
		SpeechText.addMsg(world.playerName + ": and yeah, of course! I can’t believe I started recess by tripping over a banana peel!")
		
func selectedOption(option):
	if (progress == 2):
		if (option == 1):
			SpeechText.addMsg(world.playerName + ": But wait...is that actually true? At least I brought my card. It could have been worse.")
		SpeechText.addMsg("Driver: see? There are plenty of people like you. Some of them even deliberately try not to pay.")
		SpeechText.playNext()
		progress = 3
		
