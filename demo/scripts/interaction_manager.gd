extends Node2D

@onready var player: CharacterBody2D = Global.playerBody
@export var label: Label

const base_text = "[E] to "

var active_areas = []
var can_interact = true

func register_area(area: InteractionArea):
	active_areas.push_back(area)
	
func unregister_area(area: InteractionArea):
	var index = active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index)

func _ready():
	if not label:  # If the label node is not found
		label = Label.new()  # Create a new Label node
		label.text = "[E] to interact"  # Set the label's text
		label.z_index = 20  # Set any other properties as needed
		label.anchor_left = 0.5
		label.anchor_right = 0.5
		label.offset_left = -52.5
		label.offset_right = 52.5
		label.offset_bottom = 23.0
		label.grow_horizontal = 2
		label.horizontal_alignment = 1
		label.vertical_alignment = 1
		add_child(label)  # Add the new Label as a child to the InteractionManager

func _process(_delta):
	if active_areas.size() > 0 && can_interact:
		active_areas.sort_custom(_sort_by_distance_to_player)
		label.text = base_text + active_areas[0].action_name
		label.global_position = active_areas[0].global_position
		label.global_position.y -= 36
		label.global_position.x -= label.size.x/2
		label.show()
	else:
		label.hide()


func _sort_by_distance_to_player(area1, area2):
	var area1_to_player = player.global_position.distance_to(area1.global_position)
	var area2_to_player = player.global_position.distance_to(area2.global_position)
	return area1_to_player < area2_to_player

func _input(event):
	if event.is_action_pressed("interact") && can_interact:
		if active_areas.size() > 0:
			can_interact = false
			label.hide()
			
			await active_areas[0].interact.call()
			
			can_interact = true
