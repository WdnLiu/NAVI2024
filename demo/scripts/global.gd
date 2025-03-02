extends Node

@onready var deathTimer: Timer = $DeathTimer
const initialCutScene = preload("res://scenes/initial_cutscene.tscn")

var playerBody: CharacterBody2D
var sanity: int = 100

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("reset_game"):
		get_tree().reload_current_scene()
