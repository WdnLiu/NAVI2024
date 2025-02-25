extends Area2D
@onready var timer: Timer = $Timer
var player: CharacterBody2D

func _on_body_entered(_body: Node2D) -> void:
	if player.damageable:
		print("Player Died")
		timer.start()

func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()

func _ready() -> void:
	player = Global.playerBody
