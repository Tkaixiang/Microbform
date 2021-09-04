extends Control

onready var Meter = $Meter
const MAX_LENGTH = 180
const MIN_LENGTH = 5

func _ready():
	pass # Replace with function body.

# Level is a float value between 0 to 1
func setAnxietyLevel(level):
	Meter.rect_size = Vector2((MAX_LENGTH-MIN_LENGTH) * level, 21.0)
	Meter.color = Color8(int(level * 255.0), 136 - (level * 136), 12, 255)
