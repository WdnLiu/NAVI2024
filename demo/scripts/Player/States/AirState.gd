extends State
class_name AirState

@export var groundState : State
@onready var landing: AudioStreamPlayer = $"../../Sounds/Landing"

@export var jumpSpeed : float = -350

var canJump: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func state_input(event : InputEvent):
	if (event.is_action_pressed("jump") && canJump):
		jump()
		canJump = false

func jump():
	sound()
	character.velocity.y = jumpSpeed

func stateProcess(delta : float):
	character.velocity += character.get_gravity() * delta
	
	if (character.is_on_floor()):
		nextState = groundState
	_process_animation()
		
func _process_animation() -> void:
	character.animationTree.set("parameters/Jump/blend_position", 0)

func onExit():
	character.animationTree.set("parameters/conditions/jump", false)
	sound() 
	
func onEnter() -> void:
	character.animationTree.set("parameters/conditions/jump", true)
	if character.unlockedDoubleJump:
		canJump = true
	
func sound() -> void:
	landing.pitch_scale = randf_range(0.8, 1.2)
	landing.play()
