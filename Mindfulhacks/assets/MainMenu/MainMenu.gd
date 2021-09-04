extends Node2D


onready var root = get_tree().current_scene
onready var CreditsMenu = $CreditsMenu
onready var MainPanel = $MainPanel

func _ready():
	CreditsMenu.visible = false
	
func _on_Start_pressed():
	root.gotoScene("res://Rooms/StartingRoom.tscn")
	
func _on_Credits_pressed():
	MainPanel.visible = false
	CreditsMenu.visible = true

func _on_CreditsBack_pressed():
	MainPanel.visible = true
	CreditsMenu.visible = false
