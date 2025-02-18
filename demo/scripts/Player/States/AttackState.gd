extends State
class_name AttackState

@export var groundState : State

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func stateProcess(_delta: float) -> void:
	pass

func _processAnimation():
	pass

func onEnter() -> void:
	character.animationTree.set("parameters/conditions/finishAttack", false)



func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if (anim_name == "attack"):
		nextState = groundState
		character.animationTree.set("parameters/conditions/attack", false)
		character.animationTree.set("parameters/conditions/finishAttack", true)
