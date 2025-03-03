extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sanity_bar: ProgressBar = %SanityBar

@onready var already_interacted = false

const lines: Array[String] = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")


func _on_interact():
	#DialogManager.start_dialog(global_position, lines)
	#await DialogManager.dialog_finished
	if (!already_interacted):
		sanity_bar.local_sanity -= 50
		already_interacted = true
