extends Node
class_name CharacterStateMachine

@export var character : CharacterBody2D
@export var currentState : State
var states : Array[State]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if (child is State):
			states.append(child)
			
			child.character = character
		else:
			push_warning("Child " + child.name + " node is not part of state machine")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if (currentState.nextState != null):
		switchStates(currentState.nextState)
	
	currentState.stateProcess(delta)

func switchStates(newState : State):	
	if (currentState != null):
		currentState.onExit()
		currentState.nextState = null
		
	currentState = newState
	currentState.onEnter()

func checkCanMove():
	return currentState.canMove
	
func _input(event : InputEvent):
	currentState.state_input(event)
