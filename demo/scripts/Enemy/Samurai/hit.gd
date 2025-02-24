class_name EnemyHurtState
extends State
@onready var hit: AudioStreamPlayer2D = $"../../Sounds/Hit"
@export var groundState: EnemyGroundState

#TODO: implement being able to be hit on air, currently can only return to ground state
var previousState: State

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func stateProcess(delta : float):	
	character.velocity = Vector2.ZERO
	
func onEnter() -> void:
	character.animationTree.set("parameters/conditions/finishedDamaged", false)
	character.canBeHit = false
	hit.play()

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if (character.health == 0):
		character.queue_free()
	
	if (anim_name == "hurt"):
		nextState = groundState
		character.animationTree.set("parameters/conditions/damaged", false)
		character.animationTree.set("parameters/conditions/finishedDamaged", true)
		character.canBeHit = true
