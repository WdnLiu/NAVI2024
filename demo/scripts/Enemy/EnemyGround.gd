extends State
class_name EnemyGroundState

@export var jumpSpeed : float = -350
@export var airState : State
@onready var direction_timer: Timer = $"../../DirectionTimer"
var prev_direction : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func stateProcess(delta: float) -> void:
	platform_edge()
	if ( not character.is_on_floor()):
		nextState = airState	
	if !character.dead:
		if !character.chasing:
			character.velocity.x = min(abs(character.velocity.x + character.direction * character.acc), character.SPEED) * character.direction
	elif character.dead:
		character.velocity.x = 0
	_process_animation()
	
func jump():
	character.velocity.y = jumpSpeed

func state_input(event : InputEvent):
	pass

func _process_animation() -> void:
	
	if character.direction != 0 :
		character.animationTree.set("parameters/conditions/moving", true)
		character.animationTree.set("parameters/conditions/idle", false)
	else:
		character.animationTree.set("parameters/conditions/moving", false)
		character.animationTree.set("parameters/conditions/idle", true)
		
	character.animationTree.set("parameters/moving/blend_position", 0)
	character.animationTree.set("parameters/idle/blend_position", 0)

func onEnter() -> void:
	_process_animation()

func onExit() -> void:
	character.animationTree.set("parameters/conditions/moving", false)
	character.animationTree.set("parameters/conditions/idle", false)
	
func _on_direction_timer_timeout() -> void:
	direction_timer.wait_time = choose([1.0,2.0,1.5])
	if !character.chasing:
		prev_direction = character.direction
		character.direction = choose([-1,0,1])
		if character.direction != prev_direction :
			character.velocity.x = 0
	
func choose(array):
	array.shuffle()
	return array.front()

func platform_edge() -> void:
	var raycast: RayCast2D = character.get_node("RayCast2D")
	if (character.direction < 0 and raycast.position.x > 0) or (character.direction > 0 and raycast.position.x < 0):
		raycast.position.x *= -1
	if not raycast.is_colliding():
		character.direction *= -1
		raycast.position.x *= -1
		character.velocity.x = 0
