extends Ability
class_name SpawnDeathAnimation

@export var deathScene: PackedScene

func use(p_user: Node2D) -> bool:
	var instance: PlayerDeath = deathScene.instantiate()
	p_user.get_parent().add_child(instance)
	
	var instancePosition: Vector2 = p_user.global_position
	
	instance.global_position = instancePosition
	update_facing_direction(p_user, instance)
	
	return true

func update_facing_direction(p_user: Node2D, instance: PlayerDeath):
	instance.animatedSprite.flip_h = p_user.leftFacing
