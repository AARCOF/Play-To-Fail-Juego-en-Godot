extends TextureRect

onready var score_label = $MarginContainer/HBoxContainer/scoreLabel
onready var counter_label = $MarginContainer/HBoxContainer/counterLabel
onready var goal_container = $MarginContainer/HBoxContainer/HBoxContainer
export (PackedScene) var goal_prefab
var current_score = 0
var current_count = 0

func _ready():
	_on_grid_update_score(current_score)
	_on_grid_update_counter(current_count)

func _on_grid_update_score(amount_to_change):
	current_score += amount_to_change
	score_label.text = str(current_score)

func _on_grid_update_counter(amount_to_change = -1):
	current_count += amount_to_change
	counter_label.text = str(current_count)

func make_goal(new_max, new_texture, new_value):
	var current = goal_prefab.instance()
	goal_container.add_child(current)
	current.set_global_values(new_max, new_texture, new_value)

func _on_GoalHoder_create_goal(new_max, new_texture, new_value):
	make_goal(new_max, new_texture, new_value)

func _on_grid_check_goal(goal_type):
	for i in range (goal_container.get_child_count()):
		goal_container.get_child(i).update_goal_values(goal_type)
