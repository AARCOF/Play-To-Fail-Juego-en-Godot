extends Control

func _on_Bttn_Play_pressed():
	get_tree().change_scene("res://Scenes/niveles/niveles.tscn")

func _on_Bttn_Option_pressed():
	$SettingsMenu.popup()


func _on_Bttn_Exit_pressed():
	get_tree().quit()
