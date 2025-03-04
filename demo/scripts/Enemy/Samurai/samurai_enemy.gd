extends Enemy
@onready var stateMachine: EnemyStateMachine = $EnemyStateMachine
@onready var animationTree: AnimationTree = $AnimationTree
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var vision_area: Area2D = $Vision_area
@onready var warning: AnimatedSprite2D = $Warning

signal enemyHurt

const SPEED = 125.0

var moving = 0  # 0 = idle, 1 = running
const acc = 5
var direction : float
var chasing = false
var initial_warning_pos : float = -7 # Set to this value to fit in the middle of the running animation
var player: CharacterBody2D # Information of the player to check its position
var player_in_are = false
@onready var chasing_timer: Timer = $ChasingTimer

func _ready():
	animationTree.active = true
	# Connect the signals of the vision area to functions
	vision_area.body_entered.connect(_on_player_entered) 
	vision_area.body_exited.connect(_on_player_exited)
	# The enemies won't be chasing you at the beginning
	warning.visible = false
	health = 2

func _physics_process(_delta: float) -> void:
	# Set horizontal velocity
	if direction != 0 && stateMachine.checkCanMove():
		velocity.x = min(abs(velocity.x + direction * acc), SPEED) * direction
	else:
		velocity.x = 0
		move_toward(velocity.x, 0, SPEED)
		
	update_facing_direction()
	move_and_slide()
	
# Flip the sprite if needed
func update_facing_direction():
	if direction < 0:
		sprite_2d.flip_h = true
	elif direction > 0:
		sprite_2d.flip_h = false
		
func _on_player_entered(body):
	if body.name == "Player": 
		chasing = true
		warning.visible = true

func _on_player_exited(body):
	if body.name == "Player": 
		chasing_timer.start()
		
func hit(damage: int, knockback: Vector2) -> void:
	super.hit(damage, knockback)
	emit_signal("enemyHurt")
	
func stop_chasing() -> void:
	chasing = false
	warning.visible = false
	
func _on_chasing_timer_timeout() -> void:
	stop_chasing()
