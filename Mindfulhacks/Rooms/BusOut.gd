extends Node2D

onready var root = get_tree().current_scene
onready var SpeechText = root.find_node("SpeechText", true, false)


### TODO: NEED TO INCREMENT ANXIETY METER VALUE IN ROOM EXIT SEQUENCE 

func _ready():
	SpeechText.connect("allDone", self, "_all_Done")
	SpeechText.connect("selectedOption", self, "selectedOption")
	# Connect signals
	# allDone is called when there is nothing left in the queue to play
	# selectedOption is called with the option number (int) when an option is pressed

func _all_Done(type):
	print("Done")


func _on_Area2D_mouse_entered():
	get_node("Area2D/pole_not_hover").hide() 
	get_node("Area2D/pole_hover").show() 


func _on_Area2D_mouse_exited():
	get_node("Area2D/pole_hover").hide() 
	get_node("Area2D/pole_not_hover").show() 


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		root.gotoScene("res://Rooms/StartingRoom.tscn")
		root.setDoorDone(0)


func _on_right2_area_entered(area):
	root.gotoScene("res://Rooms/Bus.tscn")
