extends Area2D

var targets: Array[Node2D]
@export var damage: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func applyDamage():
	for target in targets:
		if Global.sanity <= 70:
			damage *= choose([0.0, 0.0, 1.0, 1.0, 1.0,  1.0,  1.0,  1.0,  1.0,  1.0])
		target.hit(damage, Vector2(0, 0))

func _on_body_entered(body: Node2D) -> void:
	if not targets.has(body) && body.canBeHit:
		targets.append(body)
	applyDamage()

func choose(array):
	array.shuffle()
	return array.front()
