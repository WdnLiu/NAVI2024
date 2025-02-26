extends Node2D

@export var autoplay : bool = false
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var rich_text_label: RichTextLabel = $UI/Panel/VBoxContainer/RichTextLabel
@onready var typing: AudioStreamPlayer = $Sounds/Typing
@onready var bg: AudioStreamPlayer = $Sounds/BG
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

var visible_characters = 0
var player: CharacterBody2D

func _process(delta: float) -> void:
	if Global.playerBody:
		player = Global.playerBody
	else:
		print("Error: Global.playerBody no está inicializado")
	if visible_characters != rich_text_label.visible_characters:
		if visible_characters < rich_text_label.visible_characters and !typing.playing:
			typing.pitch_scale = randf_range(0.8, 1.2)
			typing.play()
		visible_characters = rich_text_label.visible_characters
	if !animation_player.is_playing() and player.callId == 2:
		player.onCall = false
		bg.stop()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == Global.playerBody and player.callId == 1:
		bg.play()
		animation_player.play("call1")
		player.onCall = true
		player.callId += 1
