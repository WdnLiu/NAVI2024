extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 200.0
const JUMP_VELOCITY = -350.0

# NOTE THAT PLAYER IS AT LAYET 2

var moving = 0  # 0 = idle, 1 = running
var transition = false  # Whether a transition animation is playing

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
	if direction > 0:
		animated_sprite_2d.flip_h = false
	if direction < 0:
		animated_sprite_2d.flip_h = true

	# Update animations
	update_animation(direction)

	# Set horizontal velocity
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

# Animation handling function
func update_animation(direction: int) -> void:
	if transition:
		# If a transition animation is playing, wait for it to finish
		if not animated_sprite_2d.is_playing():
			transition = false
			# After transition, set the correct looping animation
			if moving == 0:
				animated_sprite_2d.play("idle_combat")
			elif moving == 1:
				animated_sprite_2d.play("run")
	else:
		if is_on_floor():
			if direction == 0:  # No movement
				if moving == 1:  # Transition from run to idle
					animated_sprite_2d.play("run_to_idle")
					moving = 0
					transition = true
				elif animated_sprite_2d.animation != "idle_combat":  # Already idle
					animated_sprite_2d.play("idle_combat")
			else:  # Movement detected
				if moving == 0:  # Transition from idle to run
					animated_sprite_2d.play("idle_to_run")
					moving = 1
					transition = true
				elif animated_sprite_2d.animation != "run":  # Already running
					animated_sprite_2d.play("run")
		else:  # In the air
			if animated_sprite_2d.animation != "jump":
				animated_sprite_2d.play("jump")
