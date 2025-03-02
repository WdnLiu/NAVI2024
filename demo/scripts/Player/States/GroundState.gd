extends State
class_name GroundState

@onready var jump_sound: AudioStreamPlayer = $"../../Sounds/JumpSound"

@export var jumpSpeed : float = -350
@export var airState : State
@export var attackState : State
@export var rollState : State

var canRoll : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func stateProcess(_delta: float) -> void:
	if (character.isDead):
		return
	if (not character.is_on_floor()):
		nextState = airState
	if (!character.onCall):
		_process_animation()
	
func jump():
	sound()
	character.velocity.y = jumpSpeed

func state_input(event : InputEvent):
	if (character.isDead):
		return
	if (!character.onCall):
		if (event.is_action_pressed("jump")):
			jump()
			
			nextState = airState
		if (event.is_action_pressed("attack")):
			attack()
			
		if (event.is_action_pressed("roll") && canRoll && character.unlockedRoll):
			roll()

func attack():
	nextState = attackState
	character.animationTree.set("parameters/conditions/attack", true)

func roll():
	nextState = rollState
	character.animationTree.set("parameters/conditions/roll", true)
	$"../../Timers/RollCD".start()
	canRoll = false

func _process_animation() -> void:
	
	if character.direction != 0 :
		character.animationTree.set("parameters/conditions/run", true)
		character.animationTree.set("parameters/conditions/idle", false)
	else:
		character.animationTree.set("parameters/conditions/run", false)
		character.animationTree.set("parameters/conditions/idle", true)
		
	character.animationTree.set("parameters/Run/blend_position", 0)
	character.animationTree.set("parameters/Idle/blend_position", 0)
	character.animationTree.set("parameters/IdleToRun/blend_position", 0)
	character.animationTree.set("parameters/RunToIdle/blend_position", 0)
	character.animationTree.set("parameters/Attack/blend_position", 0)

func onEnter() -> void:
	_process_animation()

func onExit() -> void:
	character.animationTree.set("parameters/conditions/run", false)
	character.animationTree.set("parameters/conditions/idle", false)
	
func sound() -> void:
	jump_sound.play()

func _on_roll_cd_timeout() -> void:
	canRoll = true
