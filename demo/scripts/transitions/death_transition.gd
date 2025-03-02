extends CanvasLayer

@onready var colorRect : ColorRect = $ColorRect
@onready var animationPlayer : AnimationPlayer = $AnimationPlayer

signal on_transition_finished

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	colorRect.visible = false
	animationPlayer.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(anim_name: String):
	if (anim_name == "fade_to_dark"):
		on_transition_finished.emit()
		animationPlayer.play("fade_to_normal")
	elif (anim_name == "fade_to_normal"):
		colorRect.visible = true

func transition():
	colorRect.visible = true 
	animationPlayer.play("fade_to_dark")
