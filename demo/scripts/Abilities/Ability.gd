extends Resource
class_name Ability

func use(_p_user: Node2D) -> bool:
	push_error("Virtual method, implement in child class")
	return false
