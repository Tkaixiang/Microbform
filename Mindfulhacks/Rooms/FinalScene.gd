extends Node2D

onready var player = $Player
onready var SpeechText = $Player/Camera2D/SpeechText
onready var AnxietyMeter = $Player/Camera2D/AnxietyMeter
onready var end = $EndScene
onready var world = get_node("/root/World")
var progress = 0

func _ready():
	SpeechText.connect("allDone", self, "_all_Done")
	SpeechText.connect("selectedOption", self, "selectedOption")
	player.movement = false
	end.visible = false
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
		SpeechText.setPic("res://Rooms/mcb_panic.png")
		SpeechText.addMsg(world.playerName + ": I smell...noodles? Ah!! Noodles!! I just spilled that on myself today!!")
		SpeechText.addMsg("Cook: woah, you’re still thinking about that?")
		SpeechText.addMsg(world.playerName + ": you! You’ve been following me around as well!?")
		SpeechText.addMsg(world.playerName + ": and yeah, of course! I can’t believe I started recess by tripping over a banana peel!")
		SpeechText.addQuestion("Your response: ", ["That bruise I got must have looked really ugly! I probably look really stupid.", "I guess that’s actually the fault of whoever left the banana peel there, in hindsight."])
		SpeechText.playNext()
		progress = 5
	elif (progress == 6):
		SpeechText.setPic("res://Rooms/mcb_mildpanic.png")
		SpeechText.addMsg(world.playerName + ": That’s true...but, when I tried to pay for a small bowl of noodles with a fifty dollar bill…")
		SpeechText.addQuestion("Your response: ", ["That must have made me seem like such a snob! I mean, that’s just showing off!", "But on the bright side, that friend of mine was really nice...I eventually managed to clean myself up in the end, as well."])
		SpeechText.playNext()
		progress = 7
	elif (progress == 9):
		SpeechText.setPic("res://assets/Player/playerBase.png")
		SpeechText.addMsg('You’re right...what matters is that I clean up after my mistakes to the best of my ability. I’m glad to have friends who are always ready to help, as well.')
		SpeechText.playNext()
		progress = 10
	elif (progress == 10):
		SpeechText.setPic("res://Rooms/mcb_mildpanic.png")
		player.deactiveGhosts("Bus")
		player.activateGhosts("Street")
		SpeechText.addMsg(world.playerName + ": wait-- i-it's you... did you end up at the correct place or not!? I’m pretty sure I told you to go the wrong way!!")
		SpeechText.addQuestion("Your response: ", [" I’m so sorry aaaaaaaaaa I repent for my grave sins with all my mortal possessions", "you don’t look too angry...did you end up at the right place after all?"])
		SpeechText.playNext()
		progress = 11
	elif (progress == 12):
		SpeechText.setPic("res://assets/Player/playerBase.png")
		SpeechText.addMsg(world.playerName + ": huh...I guess I should have more faith in myself next time, and these strangers as well. After all, being able to provide a bit of help is probably still better than nothing at all.")
		SpeechText.addMsg(world.playerName + ": even though all those things happened, in the end, I guess I found out what really mattered to me and what didn’t.")
		SpeechText.addMsg(world.playerName + ": there are a lot of things I don’t have control over, and I don’t have to blame myself for bad luck.")
		SpeechText.addMsg(world.playerName + ": What’s important is whether I achieved what I set out to do. And that if I make any mistakes, I try my best to fix them.")
		SpeechText.addMsg(world.playerName + ": It’s also the challenges I face in life that show me who my true friends are, and through other people’s difficulties that I can offer my help!")
		SpeechText.addMsg(world.playerName + ": Today sure was eventful, huh? ")
		SpeechText.addMsg(world.playerName + ": But you know what, after today, I think I learnt a lot!")
		SpeechText.addMsg(world.playerName + ": my anxiety won’t just disappear, but how I act and reflect will help me along the way!")
		SpeechText.addMsg(world.playerName + ": There are many others like me too, and we’re all in this together!")
		SpeechText.addMsg(world.playerName + ": I got over some obstacles today. I’m confident I can do that in the future again!")
		SpeechText.playNext()
		progress = 13
	elif (progress == 13):
		end.visible = true
	
func selectedOption(option):
	if (progress == 2):
		if (option == 1):
			SpeechText.addMsg(world.playerName + ": But wait...is that actually true? At least I brought my card. It could have been worse.")
		SpeechText.addMsg("Driver: see? There are plenty of people like you. Some of them even deliberately try not to pay.")
		SpeechText.playNext()
		progress = 3
	elif (progress == 5):
		if (option == 1):
			SpeechText.addMsg(world.playerName + ": but if I saw someone with a bruise on their face, would I automatically think they were stupid…? Probably not…")
		SpeechText.addMsg("Cook: yeah, people who litter are really irresponsible. If everyone littered, you wouldn’t be the only person with a nasty bruise.")
		SpeechText.playNext()
		progress = 6
	elif (progress == 7):
		if (option == 1):
			SpeechText.addMsg(world.playerName + ":But that wasn’t my intention...and I guess it’s easier for the vendors to count money?")
		SpeechText.addMsg("Cook: that’s right. Actually, did you know a lot of students pay with large bills at the start of the week? Because their parents give them large bills for their allowance.")
		SpeechText.addMsg(world.playerName + ": Right, right, but...how about when I spilled the noodles!?")
		SpeechText.addQuestion("Your response: ", ["That was such a waste of money!! And I must have looked like some uncoordinated potato…", "ut on the bright side, that friend of mine was really nice...I eventually managed to clean myself up in the end, as well."])
		SpeechText.playNext()
		progress = 8
	elif (progress == 8):
		if (option == 1):
			SpeechText.addMsg(world.playerName + ":As the saying goes, “no point crying over spilt noodles”, though?")
		SpeechText.addMsg("Cook: plenty of these kinds of accidents happen, we’re used to it! Just make sure to clean up any spillage as much as you can, so the cleaners don’t have to do so much work.")
		SpeechText.playNext()
		progress = 9
	elif (progress == 11):
		if (option == 1):
			SpeechText.addMsg(world.playerName + ":Hold on, I haven’t even asked for what actually happened")
		SpeechText.addMsg("Glasses: Yeah! To be honest, I kinda forgot your directions after a while, but at least you pointed me in the directions where there were a lot of signboards to help me. So in the end, you did help me!")
		SpeechText.playNext()
		progress = 12


func _on_Back_pressed():
	world.gotoScene("res://Rooms/MainMenu.tscn")
