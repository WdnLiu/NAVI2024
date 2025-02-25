extends ProgressBar

@onready var timer: Timer = $Timer
@onready var change_bar: ProgressBar = $ChangeBar

var dark_purple = Color("#800080")  # Dark purple
var light_purple = Color("#CC99FF")  # Light purple
var fill_stylebox: StyleBox
var total_frames = 0

func _set_sanity(new_sanity):
	var prev_sanity = Global.sanity
	Global.sanity = min(max_value, new_sanity)
	value = Global.sanity

	if Global.sanity <= 0:
		get_tree().reload_current_scene()

	if Global.sanity < prev_sanity:
		timer.start()

	update_fill_color()

func init_sanity(_sanity):
	Global.sanity = _sanity
	max_value = _sanity
	value = _sanity
	change_bar.max_value = _sanity
	change_bar.value = _sanity

func update_fill_color():
	var color = dark_purple.lerp(light_purple, value / max_value)
	fill_stylebox.bg_color = color 

func _ready() -> void:
	fill_stylebox = self.get_theme_stylebox("fill")
	init_sanity(100)

func _process(_delta: float) -> void:
	total_frames += 1
	if int(total_frames) % 60 == 0:
		_set_sanity(Global.sanity - 1)

func _on_timer_timeout() -> void:
	change_bar.value = Global.sanity
