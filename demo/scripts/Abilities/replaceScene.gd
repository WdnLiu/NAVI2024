extends Node
class_name ReplaceScene

@export var replaceTarget : Node2D
@export var replacementScenePath : String

func replace():
	var instance : Node2D = load(replacementScenePath).instantiate()
	replaceTarget.get_parent().add_child(instance)
	instance.global_position = replaceTarget.global_position
