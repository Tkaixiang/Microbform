extends Node2D
onready var root = get_tree().current_scene
onready var anxietyLevel = root.get("anxietyMeter")
onready var player = $Player
onready var canteen_player = $CanteenPlayer
# onready var playerNoodles = $PlayerNoodles
onready var SpeechText = $CanvasLayer/SpeechText
var initState = 0
var playerName = "MCB"

var playerNoodlesScene = preload("res://assets/Player/PlayerNoodles.tscn")
var playerNoodles = playerNoodlesScene.instance()

var bananaDoneState = false
var noodleStallDoneState = false
var spillDoneState = false

var already_added = false 

func _ready():
	player.movement = false
	SpeechText.connect("allDone", self, "_all_Done")
	SpeechText.connect("selectedOption", self, "selectedOption")
	initState = 1
	
	SpeechText.setPic("res://assets/Player/playerBase.png")
	SpeechText.addMsg("After a disastrous bus trip, you finally reach school.")
	SpeechText.addMsg("~~This is an innocent time skip~~")
	
	SpeechText.addMsg("Now, do you find your surroundings suspiciously familiar? ")
	SpeechText.addMsg("Indeed, this is the source of nightmare, an unholy ground filled with malicious traps and evilness lurking behind pillars, the 18th floor of purgatory.")
	SpeechText.addMsg("The Canteen.")
	SpeechText.addMsg("Perhaps you feel overwhelmed by the chaotic waves of people before your eyes, or the near-deafening sounds of noisy conversations and frequent...")
	SpeechText.addMsg("...abrupt screams. Perhaps you shrink away the eyes of strangers judging every single of your gestures. Perhaps you are too sharply aware of...")
	SpeechText.addMsg("... your lonesome figure, and are leaning towards deciding that the chocolate bar from the distant vending machine would make for a more wonderful...")
	SpeechText.addQuestion("...lunch instead.", ["Neither god nor demon shall take away my food!", "My anxiety is all in my head. I'm just buying lunch, what the heck...", "*Brain already short-circuited."])
	SpeechText.playNext()

func _all_Done(type):
	print("Done")
		
func selectedOption(option):
	
	if noodleStallDoneState && already_added == false:  
		already_added = true 
		
		get_parent().add_child(playerNoodles)
		playerNoodles.position = player.global_position
		playerNoodles.movement = true
		self.remove_child(player)
		
		
	if spillDoneState:
		get_parent().add_child(canteen_player)
		player.position = playerNoodles.global_position
		player.movement = true
		get_parent().remove_child(playerNoodles)
		
		exit_sequence()

	player.movement = true
	SpeechText.stopNReset()

func exit_sequence(): 
	root.setDoorDone(1)
	root.setAnxietyMeter(anxietyLevel + 0.3)
	root.gotoScene("res://Rooms/StartingRoom.tscn")

func _on_Banana_area_entered(area):
	
	if (not bananaDoneState):
		player.movement = false
		
		SpeechText.addMsg("Crash!")
		SpeechText.addMsg("As you are wondering why your world has suddenly turned 180 degrees, a burst of stinging pain registers in your knees.")
		SpeechText.addMsg("Congratulations on triggering the flag of one of the most embarassing incidents that can happen in a canteen, tripping over a banana peel!")
		
		SpeechText.addMsg("Almost everybody's gazes are on your body, and no, this time it is not your made-up illusion.")
		SpeechText.addMsg("As you slowly stand up, uncontrollable thoughts such as 'I want to jump into a hole right now' and 'Why am I so stupid goddamnit' pour into...")
		SpeechText.addMsg("...your mind.")
		SpeechText.addMsg("It feels as if the stares of the people around you are full of judgement and disdain for your idiocy.")
		
		SpeechText.addQuestion("What will you do?", ["Go into panic attack mode.", "Smile. Tripping over things is perfectly normal human behavior.", "Take a deep breath, and continue walking forward. Your stomach is still growling."])
		SpeechText.playNext()
		
		bananaDoneState = true

func _on_NoodleStall_area_entered(area):
	
	if bananaDoneState && (not noodleStallDoneState):
		noodleStallDoneState = true
		player.movement = false
		
		SpeechText.addMsg("Regardless, pigs need to fly and people need to eat.")
		SpeechText.addMsg("You suddenly experience an intense sense of longing for pork - particularly the soft, fragrant, absolutely appetizing pork ramen at...")
		SpeechText.addMsg("...the Noodles store.")
		SpeechText.addMsg("~~Tick. Tock. Tick. Tock. I'm an innocent clock~~")
		SpeechText.addMsg("After waiting patiently for ten minutes, you finally find yourself face-to-face with a mouth-watering bowl of steaming noodles.")
		SpeechText.addMsg("By now, your negative emotions from the fall have mostly dissipated.")
		
		SpeechText.addMsg("You heard the auntie saying, 'Yours is three dollars and fifty cents ah.'")
		SpeechText.addMsg("The auntie's voice sounds as pleasant as that of an angel to you - an angel who can gaze into one's soul and fulfil their utmost desire.")
		SpeechText.addMsg("For your present self, that desire happens to be eating a hot, tantazing meal.")
		SpeechText.addMsg("A genuine smile appears on your face, and although you always feel that your smile looks worse than a grimace, the auntie can still see your abnormally...")
		SpeechText.addMsg("...sincere eyes, right?")
		
		SpeechText.addMsg("You pull out your wallet and examine its content. A sole, hazardly folded fifty-dollar bill lies quietly within.")
		
		SpeechText.addMsg("Your smile freezes over.")
		SpeechText.addMsg("You attempt to pull out your phone for NETS payment, but realize with horror that the Singtel 4G mobile data network has collapsed yet again.")
		SpeechText.addMsg("You take a deep breath and hand the fifty-dollar bill to the auntie, who now wears a look you interpret as disdain.")
		SpeechText.addQuestion("What will you do?", ["In a mosquito's voice, apologize wearing the most awkward expression possible.", "Do nothing. What's wrong with a government-distributed 50-dollar bill?", "Do nothing, but wallow in shame on the inside."])
		SpeechText.playNext()
		
func _on_Spill_area_entered(area):
	
	if bananaDoneState && noodleStallDoneState && (not spillDoneState):
		spillDoneState = true
		playerNoodles.movement = false
		
		playerNoodles.activateSpill()
				
		SpeechText.addMsg("Whoosh!")
		SpeechText.addMsg("Are you pleasantly surprised at the sequence of events?")
		SpeechText.addMsg("Your first thought is 'There goes the better half of my three dollars fifty cents'.")
		SpeechText.addQuestion("Your second thought is...", ["Humans are like clouds, and a sense of shame is water vapor.", "Nothing. So tired - you don't even feel the need to dig a hole anymore.", "Bye bye, reputation."])
		SpeechText.playNext()
