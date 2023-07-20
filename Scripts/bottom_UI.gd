extends TextureRect

func _on_quitButton_pressed():
	get_tree().change_scene("res://Scenes/subnivel/subnivel(nivel4).tscn")

func _on_restoreButton_pressed():
	get_tree().reload_current_scene()
