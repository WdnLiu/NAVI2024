extends Ability
class_name SlashUse

@export var slashScene: PackedScene
@export var instancingOffset: Vector2

func use(p_user: Node2D) -> bool:
	var instance: Slash = slashScene.instantiate()
	p_user.get_parent().add_child(instance)
	
	var direction: float = signf(p_user.direction)
	
	var finalOffset = Vector2(
		instancingOffset.x * direction,
		instancingOffset.y
	)
	
	var instancePosition: Vector2 = p_user.global_position+finalOffset
	instance.global_position = instancePosition
	update_facing_direction(p_user, instance)
	
	return true

func update_facing_direction(p_user: Node2D, instance: Slash):
	instance.animatedSprite.flip_h = p_user.leftFacing
