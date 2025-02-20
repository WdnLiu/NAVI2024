class_name Enemy
extends CharacterBody2D

@export var canBeHit: bool = true
@export var health: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func hit(damage: int, knockback: Vector2):
	health -= damage
	velocity += knockback
