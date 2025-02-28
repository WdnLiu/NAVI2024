extends Node2D
@onready var animation_tree: AnimationTree = $AnimationTree
@export var autoplay : bool = false
@export var next_scene : PackedScene
@onready var typing: AudioStreamPlayer = $Sounds/Typing

var visible_characters = 0
@onready var rich_text_label: RichTextLabel = $UI/Panel/VBoxContainer/RichTextLabel

func _input(event):
	if event.is_action_pressed("next"):
		change_scene()
		
func change_scene():
	get_tree().change_scene_to_packed(next_scene)

func _process(delta: float) -> void:
	if visible_characters != rich_text_label.visible_characters:
		if visible_characters < rich_text_label.visible_characters and !typing.playing:
			typing.pitch_scale = randf_range(0.8, 1.2)
			typing.play()
		visible_characters = rich_text_label.visible_characters
