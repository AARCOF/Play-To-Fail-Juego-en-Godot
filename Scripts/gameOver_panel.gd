extends "res://Scripts/BaseMenuPanel.gd"

func _on_restart_buttom_pressed():
	get_tree().reload_current_scene()

func _on_quit_buttom_pressed():
	#Hacer redirección a los niveles
	#get_tree().change_scene()
	pass

func _on_grid_game_over():
	slide_in()
