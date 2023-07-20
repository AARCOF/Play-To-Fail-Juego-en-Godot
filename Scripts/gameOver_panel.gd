extends "res://Scripts/BaseMenuPanel.gd"

func _ready():
	pass # Replace with function body.

func _on_restart_buttom_pressed():
	get_tree().reload_current_scene()

func _on_quit_buttom_pressed():
	get_tree().change_scene("res://Scenes/subnivel/Subnivel(nivel4).tscn")

func _on_grid_game_over():
	slide_in()
