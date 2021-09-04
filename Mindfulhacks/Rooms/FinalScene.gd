extends Node2D

onready var player = $Player
onready var SpeechText = $Player/Camera2D/SpeechText
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
		SpeechText.addMsg("Mcb: woah--!? You! You’ve been following me this whole time, right? ")
		SpeechText.addMsg("Driver: yeah, because you couldn’t stop feeling guilty about your bus trip.")
		SpeechText.addMsg('Mcb: Of course not! Remember when I tried to tap in?')
