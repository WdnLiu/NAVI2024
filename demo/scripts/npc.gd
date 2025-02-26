extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sanity_bar: ProgressBar = %SanityBar

@onready var already_interacted = false

const lines: Array[String] = [
	"Ah... another one.",
	"They send you to clean up their mess too?",
	"Do you even remember signing up for this?",
	"Or did he just tell you that you did?",
	"You don't trust me. Good. You shouldn't trust anyone.",
	"Especially him."
]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")


func _on_interact():
	DialogManager.start_dialog(global_position, lines)
	await DialogManager.dialog_finished
	if (!already_interacted):
		sanity_bar.local_sanity -= 50
		already_interacted = true
