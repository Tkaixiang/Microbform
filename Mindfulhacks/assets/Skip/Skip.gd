extends Control

onready var world = self.get_node("/root/World")
var room = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	if (world.scenePath == "res://Rooms/Bus.tscn"):
		room = 0
	elif (world.scenePath == "res://Rooms/Canteen.tscn"):
		room = 1
	elif (world.scenePath == "res://Rooms/Streets.tscn"):
		room = 2
		

func _on_Button_pressed():
	world.gotoScene("res://Rooms/StartingRoom.tscn")
	world.setDoorDone(room)
