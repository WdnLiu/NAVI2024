extends Node2D
@onready var animation_tree: AnimationTree = $AnimationTree
@export var autoplay : bool = false
@export var next_scene : PackedScene

func _input(event):
	if event.is_action_pressed("next"):
		change_scene()
		
func change_scene():
	get_tree().change_scene_to_packed(next_scene)
