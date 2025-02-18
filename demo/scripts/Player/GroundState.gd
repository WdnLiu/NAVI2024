extends State
class_name GroundState

@export var jumpSpeed : float = -350
@export var airState : State
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func stateProcess(delta: float) -> void:
	if ( not character.is_on_floor()):
		nextState = airState
		
	_process_animation()
	
func jump():
	character.velocity.y = jumpSpeed

func state_input(event : InputEvent):
	if (event.is_action_pressed("jump")):
		jump()
		
		nextState = airState

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

func onEnter() -> void:
	_process_animation()

func onExit() -> void:
	character.animationTree.set("parameters/conditions/run", false)
	character.animationTree.set("parameters/conditions/idle", false)
