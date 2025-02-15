extends State
class_name EnemyAirState

@export var groundState : State

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func stateProcess(delta : float):
	character.velocity += character.get_gravity() * delta
	
	if (character.is_on_floor()):
		nextState = groundState
	_process_animation()
		
func _process_animation() -> void:
	pass

func onExit():
	pass
	
func onEnter() -> void:
	pass
