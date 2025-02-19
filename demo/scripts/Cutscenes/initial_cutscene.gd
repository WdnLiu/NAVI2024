extends Node2D
@onready var animation_tree: AnimationTree = $AnimationTree
@export var autoplay : bool = false

func _input(event):
	if event.is_action_pressed("next") and not animation_tree.is_playing():
		animation_tree.play()
