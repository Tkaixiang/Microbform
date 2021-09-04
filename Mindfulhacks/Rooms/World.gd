extends Node2D

onready var currentScene = null
onready var startingRoom = null
onready var SceneChangeAnime = $SceneChangeAnime
var playerName = ""
var scenePath = ""
var doorDoneState = [false, false, false]
var doorDones = 0
var anxietyMeter = 0.1
var meter = null

func _ready():
	gotoScene("res://Rooms/MainMenu.tscn")
	
func gotoScene(path):
	scenePath = path
	SceneChangeAnime.stop(true)
	SceneChangeAnime.play("FadeOut")

# Number: 0-2
func setDoorDone(number):
	doorDones += 1
	doorDoneState[number] = true
	startingRoom.setDoorDone(number)
	
func setAnxietyMeter(number, showAnim=false):
	anxietyMeter = number
	if (meter != null):
		meter.setAnxietyLevel(anxietyMeter, showAnim)
	
	
func _on_SceneChangeAnime_animation_finished(anim_name):
	
	if (anim_name == "FadeOut"):
		self.remove_child(currentScene)
		# Restore starting room scene instead of re-instancing it
		if (scenePath.find("StartingRoom") != -1):
			
			
			if (doorDones != 3):
				if (startingRoom != null):
					self.add_child(startingRoom)
					currentScene = startingRoom
				else:
					var scene = load(scenePath)
					var sceneInstance = scene.instance()
					startingRoom = sceneInstance
					currentScene = sceneInstance
					self.add_child(sceneInstance)
			else:
				var scene = load("res://Rooms/FinalScene.tscn")
				var sceneInstance = scene.instance()
				startingRoom = sceneInstance
				currentScene = sceneInstance
				self.add_child(sceneInstance)
		else:
			var scene = load(scenePath)
			var sceneInstance = scene.instance()
			self.add_child(sceneInstance)
			currentScene = sceneInstance
		
		meter = currentScene.find_node("AnxietyMeter", true, false)
		if (meter != null):
			meter.setAnxietyLevel(anxietyMeter)
		var player = currentScene.find_node("Player", true, false)
		if (player != null):
			if (doorDoneState[0] == true):
				player.activateGhosts("bus")
			if (doorDoneState[1] == true):
				player.activateGhosts("canteen")
			if (doorDoneState[2] == true):
				player.activateGhosts("street")
		
		SceneChangeAnime.play("FadeIn")
