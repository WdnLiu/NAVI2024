extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var coyote_timer: Timer = $CoyoteTimer
@onready var jump_buffer_timer: Timer = $JumpBufferTimer

const SPEED = 200.0
const JUMP_VELOCITY = -350.0

var moving = 0  # 0 = idle, 1 = running
var transition = false  # Whether a transition animation is playing
var was_on_floor = false
var jump_buffer = false

func _physics_process(delta: float) -> void:
	
	coyote_time()

	# Apply gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		if jump_buffer:
			Jump()
			jump_buffer = false

	# Handle jump with proper coyote time check
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() or coyote_timer.time_left > 0:
			Jump()
		else:
			set_jump_buffer()

	# Get the input direction
	var direction := Input.get_axis("move_left", "move_right")

	# Flip the sprite based on direction
	animated_sprite_2d.flip_h = direction < 0

	# Update animations
	update_animation(direction)

	# Set horizontal velocity
	velocity.x = direction * SPEED if direction != 0 else move_toward(velocity.x, 0, SPEED)

	move_and_slide()

# Function that contains the jump logic so it can be called from multiple places
func Jump() -> void:
	velocity.y = JUMP_VELOCITY
	coyote_timer.stop()  # Prevent multiple jumps 

# Function to handle setting the jump buffer
func set_jump_buffer() -> void:
	if not jump_buffer:  # Connect the signal only once
		jump_buffer = true
		jump_buffer_timer.start()  # Start the timer
		jump_buffer_timer.timeout.connect(on_jumpbuffer_timeout)  # Connect the timeout signal

# Function called when the timer sends the signal
func on_jumpbuffer_timeout() -> void:
	jump_buffer = false

# Handles coyote time logic
func coyote_time() -> void:
	if was_on_floor and not is_on_floor() and not Input.is_action_pressed("jump"):
		coyote_timer.start()
	was_on_floor = is_on_floor()  # Update floor state for next frame

# Animation handling function
func update_animation(direction: int) -> void:
	if transition:
		if not animated_sprite_2d.is_playing():
			transition = false
			animated_sprite_2d.play("idle_combat" if moving == 0 else "run")
	else:
		if is_on_floor():
			if direction == 0:
				if moving == 1:
					animated_sprite_2d.play("run_to_idle")
					moving = 0
					transition = true
				elif animated_sprite_2d.animation != "idle_combat":
					animated_sprite_2d.play("idle_combat")
			else:
				if moving == 0:
					animated_sprite_2d.play("idle_to_run")
					moving = 1
					transition = true
				elif animated_sprite_2d.animation != "run":
					animated_sprite_2d.play("run")
		else:
			if animated_sprite_2d.animation != "jump":
				animated_sprite_2d.play("jump")
