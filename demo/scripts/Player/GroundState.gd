extends State
class_name GroundState

@export var jumpSpeed : float = -350
@export var airState : State
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func jump():
	character.velocity.y = jumpSpeed

func state_input(event : InputEvent):
	if (event.is_action_pressed("jump")):
		jump()
		nextState = airState
