extends CharacterBody2D
@onready var stateMachine: EnemyStateMachine = $EnemyStateMachine
@onready var animationTree: AnimationTree = $AnimationTree
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var vision_area: Area2D = $Vision_area
@onready var warning: AnimatedSprite2D = $Warning

const SPEED = 125.0

var moving = 0  # 0 = idle, 1 = running
const acc = 5
var direction : float
var chasing = false
var dead = false
var initial_warning_pos : float = -7 # Set to this value to fit in the middle of the running animation
var player: CharacterBody2D # Information of the player to check its position
var player_in_are = false

func _ready():
	animationTree.active = true

func _physics_process(_delta: float) -> void:
	# Set horizontal velocity
	#if direction != 0 && stateMachine.checkCanMove():
		#velocity.x = min(abs(velocity.x + direction * acc), SPEED) * direction
	#else:
		#velocity.x = 0
		#move_toward(velocity.x, 0, SPEED)
		
	#update_facing_direction()
	move_and_slide()
