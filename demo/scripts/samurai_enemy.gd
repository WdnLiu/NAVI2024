extends CharacterBody2D
@onready var stateMachine: EnemyStateMachine = $EnemyStateMachine
@onready var animationTree: AnimationTree = $AnimationTree
@onready var sprite_2d: Sprite2D = $Sprite2D

const SPEED = 150.0

var moving = 0  # 0 = idle, 1 = running
const acc = 5
var direction : float
var chasing = false
var dead = false

func _ready():
	animationTree.active = true

func _physics_process(delta: float) -> void:
	# Set horizontal velocity
	if direction != 0 && stateMachine.checkCanMove():
		velocity.x = min(abs(velocity.x + direction * acc), SPEED) * direction
	else:
		velocity.x = 0
		move_toward(velocity.x, 0, SPEED)
	update_facing_direction()
	move_and_slide()
	
	
func update_facing_direction():
	if direction < 0:
		sprite_2d.flip_h = true
	elif direction > 0:
		sprite_2d.flip_h = false
