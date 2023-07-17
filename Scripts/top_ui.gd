extends TextureRect

onready var score_label = $MarginContainer/HBoxContainer/scoreLabel
onready var  counter_label = $MarginContainer/HBoxContainer/counterLabel
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
