extends State
class_name AirState

@export var groundState : State

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func stateProcess(delta : float):
	if (character.is_on_floor()):
		nextState = groundState
		
func onExit():
	pass 
