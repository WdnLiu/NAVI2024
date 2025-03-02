extends Node

var playerBody: CharacterBody2D
var sanity: int = 100
@export var ending1 : PackedScene
@export var ending2 : PackedScene
@export var initialCut : PackedScene

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ending1"):
		change_scene(ending1)
	
func change_scene(scene : PackedScene):
	get_tree().change_scene_to_packed(scene)
