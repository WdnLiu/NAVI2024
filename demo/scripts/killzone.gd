extends Area2D
@onready var timer: Timer = $Timer
var player: CharacterBody2D

func _on_body_entered(_body: Node2D) -> void:
	if player.damageable:
		player.hp -= 1

func _process(_delta: float) -> void:
	if Global.playerBody:
		player = Global.playerBody
	else:
		print("Error: Global.playerBody no está inicializado")

func _ready() -> void:
	pass
