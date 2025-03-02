extends TileMap


func _process(_delta: float) -> void:
	visible = Global.sanity <= 0
