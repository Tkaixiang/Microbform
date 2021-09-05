extends Node2D

onready var root = get_tree().current_scene
onready var SpeechText = root.find_node("SpeechText", true, false)


func _ready():
	root.setDoorDone(0)
	SpeechText.connect("allDone", self, "_all_Done")
	SpeechText.connect("selectedOption", self, "selectedOption")
	# Connect signals
	# allDone is called when there is nothing left in the queue to play
	# selectedOption is called with the option number (int) when an option is pressed

func _all_Done(type):
	print("Done")

func _on_buspole_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		root.gotoScene("res://Rooms/StartingRoom.tscn")

func _on_buspole_mouse_entered():
	get_node("buspole/pole_not_hover").hide() 
	get_node("buspole/pole_hover").show() 

func _on_buspole_mouse_exited():
	get_node("buspole/pole_hover").hide() 
	get_node("buspole/pole_not_hover").show() 
