extends Control

onready var world = self.get_node("/root/World")
var room = 0
var anxiety = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	if (world.scenePath == "res://Rooms/Bus.tscn"):
		room = 0
		anxiety = 0.4
	elif (world.scenePath == "res://Rooms/Canteen.tscn"):
		room = 1
		anxiety = 0.3
	elif (world.scenePath == "res://Rooms/Streets.tscn"):
		room = 2
		anxiety = 0.3
		

func _on_Button_pressed():
	world.setDoorDone(room)
	world.setAnxietyMeter(world.get("anxietyMeter") + anxiety, true)
	world.gotoScene("res://Rooms/StartingRoom.tscn")
	
