extends KinematicBody2D #Can only extend the node that your script is attached to (to use the features in it)

# shorthand for _ready()
onready var animationPlayer = $AnimationPlayer # Access a child node in the SAME SCENE
onready var animationTree = $AnimationTree
onready var busGhost = $BusGhost
onready var busGhostAnimeTree = $BusGhost/AnimationTree
onready var busAnimeState = busGhostAnimeTree.get("parameters/playback")
onready var animationState = animationTree.get("parameters/playback")
var movement = true

# Called when the node enters the scene tree for the first time.
# Any child node _ready() functions are called first.
func _ready(): # "_" means a "callback" function
	busGhost.visible = false
	animationTree.active = true # Activate animationTree

const MAX_SPEED = 60
const ACCELERATION = 280
const FRICTION = 2800

var velocity = Vector2.ZERO

func activateGhosts(ghost):
	if (ghost == "bus"):
		busGhost.visible = true


# Runs every single "physics frame"
func _physics_process(delta): # Delta is how long the last frame took to process
	if (movement):
		var input_vector = Vector2.ZERO
		input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") 
		# If pressing right key: input_vector.x = 1 - 0 = 1 (0-1)
		input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		input_vector = input_vector.normalized()
		# Normalise the vector to become a unit vector 
		# To prevent diagonal vectors from being faster
		
		# If key is pressed, add to velocity (acceleration)
		if (input_vector != Vector2.ZERO):
			velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
			
			# Set blend position so that the animation for a certain direction is triggered (for both Idle+Run)
			animationTree.set("parameters/Idle/blend_position", input_vector) 
			animationTree.set("parameters/Run/blend_position", input_vector)
			busGhostAnimeTree.set("parameters/Float/blend_position", input_vector)
			busAnimeState.travel("Float")
			animationState.travel("Run") # Activate the "Run" blendSpace2D with the input_vector blend position
		else:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			# Activate the "Idle" blendSpace2D with the last input_vector blend position (face correct idle direction)
			animationState.travel("Idle") 
			
			
		
		velocity = move_and_slide(velocity) # The larger Delta is, the larger the multiplication(move the same distance even if your framerate dies)
