extends Node
class_name PlayerAbilitiesComponent

@export var attackAction : String = "attack"
@export var ability : Ability
@export var user : Node2D

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("attack")):
		ability.use(user)
