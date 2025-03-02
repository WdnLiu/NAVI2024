extends State

@export var groundState : State

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func stateProcess(delta : float):
	character.velocity += character.get_gravity() * delta

func onEnter() -> void:
	character.animationTree.set("parameters/conditions/finishRoll", false)
	character.damageable = false
	character.velocity.x = (character.SPEED+100)*character.getDirectionSign()

func onExit() -> void:
	character.damageable = true

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if (anim_name == "rolling"):
		nextState = groundState
		character.animationTree.set("parameters/conditions/roll", false)
		character.animationTree.set("parameters/conditions/finishRoll", true)
