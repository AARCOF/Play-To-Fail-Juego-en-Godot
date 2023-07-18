extends Control

onready var audio_stream_player = $AudioStreamPlayer
onready var settings = get_node("SettingsMenu") #Conexion al SettingsMenu(PopMenu)

func _ready():
	#Conexion y llamado inicial
	settings.connect("volume_changed", self, "_on_volume_changed")

#Control de Audio por BUS	
func _on_volume_changed(bus_idx, volume):
	match bus_idx:
		0:
			audio_stream_player.set_bus_volume_db(0, volume)
		1:
			audio_stream_player.set_bus_volume_db(1, volume)
		2:
			audio_stream_player.set_bus_volume_db(2, volume)

func _on_Bttn_Play_pressed():
	get_tree().change_scene("res://Scenes/niveles/niveles.tscn")

func _on_Bttn_Option_pressed():
	$SettingsMenu.popup()


func _on_Bttn_Exit_pressed():
	get_tree().quit()
