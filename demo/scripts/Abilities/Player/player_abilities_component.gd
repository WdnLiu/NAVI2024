extends Node
class_name PlayerAbilitiesComponent

@export var attackAction : String = "attack"
@export var ability : Ability
@export var user : Node2D

func _on_attack_starting_slash() -> void:
	ability.use(user)
