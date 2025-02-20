extends ProgressBar

@onready var timer: Timer = $Timer
@onready var change_bar: ProgressBar = $ChangeBar

var sanity = 100 : set = _set_sanity
var dark_purple = Color("#800080")  # Dark purple
var light_purple = Color("#CC99FF")  # Light purple
var fill_stylebox: StyleBox
var total_frames = 0

func _set_sanity(new_sanity):
	var prev_sanity = sanity
	sanity = min(max_value, new_sanity)
	value = sanity
	
	if sanity <= 0:
		get_tree().reload_current_scene()
	
	if sanity < prev_sanity:
		timer.start()
	
	update_fill_color()

func init_sanity(_sanity):
	sanity = _sanity
	max_value = sanity
	value = sanity
	change_bar.max_value = sanity
	change_bar.value = sanity

# This method updates the fill color of the sanity bar based on its current value
func update_fill_color():
	# Interpolate between dark purple and light purple based on progress value
	var color = dark_purple.lerp(light_purple, self.value / self.max_value)

	# Set the fill color dynamically
	fill_stylebox.bg_color = color 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fill_stylebox = self.get_theme_stylebox("fill")
	init_sanity(100)
	
func _process(_delta: float) -> void:
	total_frames += 1
	
	if int(total_frames) % 60 == 0:
		sanity -= 5

func _on_timer_timeout() -> void:
	change_bar.value = sanity
