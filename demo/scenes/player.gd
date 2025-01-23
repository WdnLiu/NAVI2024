extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 200.0
const JUMP_VELOCITY = -300.0

func _physics_process(delta: float) -> void:
	
	# Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")

	# Flip the sprite based on direction
	animated_sprite_2d.flip_h = direction < 0

	update_animation(direction)

	# Set horizontal velocity
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
# Animation handling function
func update_animation(direction: int) -> void:
	if is_on_floor():
		if direction == 0:  # No movement
			animated_sprite_2d.play("idle")
		else:  # Moving on the ground
			animated_sprite_2d.play("run")
	else:  # In the air
		if animated_sprite_2d.animation != "jump":
			animated_sprite_2d.play("jump")
