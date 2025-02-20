extends Node2D
class_name Slash

@export var animatedSprite : AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_animated_sprite_2d_animation_finished() -> void:
	self.queue_free()
