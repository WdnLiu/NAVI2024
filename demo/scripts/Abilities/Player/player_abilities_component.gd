extends Node
class_name PlayerAbilitiesComponent

@export var attackAction : String = "attack"
@export var ability : Ability
@export var user : Node2D
@export var spawn : Ability
@export var death: Ability

func _on_attack_starting_slash() -> void:
	ability.use(user)


func _on_player_spawn_enemy() -> void:
	print('spawning')
	spawn.use(user)


func _on_player_player_dies() -> void:
	print('dying')
	death.use(user)
