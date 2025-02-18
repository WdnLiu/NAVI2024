extends Node
class_name State

@export var canMove : bool = true

var character : CharacterBody2D
var nextState : State

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func state_input(_event):
	pass

func stateProcess(_delta : float):
	pass

func onEnter():
	pass
	
func onExit():
	pass
