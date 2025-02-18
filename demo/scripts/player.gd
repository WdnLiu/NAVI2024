extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animatedSprite : Sprite2D = $Sprite2D
@onready var animationTree : AnimationTree = $AnimationTree
@onready var stateMachine: CharacterStateMachine = $CharacterStateMachine

const SPEED = 200.0

var moving = 0  # 0 = idle, 1 = running
var was_on_floor : bool = false
const acc = 10
@export var direction : float
@export var leftFacing : bool = false

func _ready():
	Global.playerBody = self
	animationTree.active = true

func _physics_process(_delta: float) -> void:

	# Get the input direction
	direction = Input.get_axis("move_left", "move_right")

	# Update animations
	update_facing_direction()
	
	# Check if the direction is changing
	if direction != 0 and sign(velocity.x) != direction:
		velocity.x = 0  # Hard stop before changing direction in ALL states
		
	# Set horizontal velocity
	if direction != 0 && stateMachine.checkCanMove():
		velocity.x = min(abs(velocity.x + direction * acc), SPEED) * direction
	else:
		velocity.x = 0
		move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func update_facing_direction():
	if direction < 0:
		animatedSprite.flip_h = true
		leftFacing = true
	elif direction > 0:
		animatedSprite.flip_h = false
		leftFacing = false
	
