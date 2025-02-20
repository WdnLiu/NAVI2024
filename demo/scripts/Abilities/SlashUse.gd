extends Ability
class_name SlashUse

@export var slashScene: PackedScene

const offset: Vector2 = Vector2(50, 0)

func use(p_user: Node2D) -> bool:
	var instance: Slash = slashScene.instantiate()
	p_user.get_parent().add_child(instance)
			
	var finalOffset = getFinalOffset(p_user)
	
	var instancePosition: Vector2 = p_user.global_position+finalOffset
	
	instance.global_position = instancePosition
	update_facing_direction(p_user, instance)
	
	return true

func update_facing_direction(p_user: Node2D, instance: Slash):
	instance.animatedSprite.flip_h = p_user.leftFacing

func getFinalOffset(p_user: Node2D) -> Vector2:
	var x: float = offset.x
	
	if (p_user.leftFacing):
		x *= -1
		
	return Vector2(x, offset.y)
