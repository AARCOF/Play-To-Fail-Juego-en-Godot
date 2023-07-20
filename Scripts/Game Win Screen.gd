extends "res://Scripts/BaseMenuPanel.gd"

func _on_ContinueButton_pressed():
	get_tree().change_scene("res://Scenes/niveles/niveles.tscn")

func _on_GoalHoder_game_won():
	slide_in()
