extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animatedSprite : Sprite2D = $Sprite2D
@onready var animationTree : AnimationTree = $AnimationTree
@onready var stateMachine: CharacterStateMachine = $CharacterStateMachine
@export var ending1 : PackedScene
# @export var ending2 : PackedScene

const SPEED = 200.0

var moving = 0  # 0 = idle, 1 = running
var was_on_floor : bool = false
const acc = 10
var onCall : bool = false
var callId : int = 1
@export var direction : float
@export var leftFacing : bool = false
@export var unlockedRoll : bool = false
@export var unlockedDoubleJump: bool = false
@export var damageable: bool = true
@export var hp: int = 1

func _ready():
	Global.playerBody = self
	animationTree.active = true
	unlockedRoll = false
	unlockedDoubleJump= false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ending1"):
		change_scene(ending1)

func _physics_process(_delta: float) -> void:
	unlockAbilities()
	# Get the input direction
	direction = Input.get_axis("move_left", "move_right")

	# Update animations
	update_facing_direction()
	
	# Check if the direction is changing
	if direction != 0 and sign(velocity.x) != direction:
		velocity.x = 0  # Hard stop before changing direction in ALL states
		
	# Set horizontal velocity
	if (stateMachine.currentState.name == "Roll" or onCall):
		if(onCall):
			direction = 0
			velocity.x = 0
			move_toward(velocity.x, 0, SPEED)
		pass
	elif direction != 0 && stateMachine.checkCanMove():
		velocity.x = min(abs(velocity.x + direction * acc), SPEED) * direction
	else:
		velocity.x = 0
		move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func update_facing_direction() -> void:
	if direction < 0:
		animatedSprite.flip_h = true
		leftFacing = true
	elif direction > 0:
		animatedSprite.flip_h = false
		leftFacing = false
		
func getDirectionSign() -> int:
	if (leftFacing):
		return -1
	else:
		return 1
	
func isDead() -> bool:
	return hp <= 0
	
func unlockAbilities() -> void:
	if Global.sanity <= 0 or Input.is_action_pressed("unlock_roll"):
		unlockedRoll = true
	if Global.sanity <= 50 or Input.is_action_pressed("unlock_jump"):
		unlockedDoubleJump = true

func change_scene(scene : PackedScene):
	get_tree().change_scene_to_packed(scene)
