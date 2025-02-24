extends State
class_name AttackState

@export var groundState : State
signal startingSlash
@onready var sword_a: AudioStreamPlayer2D = $"../../Sounds/SwordA"
@onready var sword_b: AudioStreamPlayer2D = $"../../Sounds/SwordB"

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
	emit_signal("startingSlash")
	sound()
	

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if (anim_name == "attack"):
		nextState = groundState
		character.animationTree.set("parameters/conditions/attack", false)
		character.animationTree.set("parameters/conditions/finishAttack", true)
		
func choose(array):
	array.shuffle()
	return array.front()

func sound():
	var attack_sound = choose([0.0,1.0])
	if attack_sound == 0:
		sword_a.pitch_scale = randf_range(0.8, 1.2)  # Random pitch variation
		sword_a.play()
	else:
		sword_b.pitch_scale = randf_range(0.8, 1.2)  # Random pitch variation
		sword_b.play()
