extends TextureRect

onready var score_label = $MarginContainer/HBoxContainer/scoreLabel
var current_score = 0

func _ready():
	_on_grid_update_score(current_score)

#func _process(delta):
#	pass


func _on_grid_update_score(amount_to_change):
	current_score += amount_to_change
	score_label.text = str(current_score)
	
