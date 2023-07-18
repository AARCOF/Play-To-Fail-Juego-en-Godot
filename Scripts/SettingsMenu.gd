extends Popup

#Audio Settings
onready var master_slider = get_node("BackgroundSettings/GridContainer/SliderMasterVolu")
onready var music_slider = get_node("BackgroundSettings/GridContainer/SliderMusicVolu")
onready var sfx_slider = get_node("BackgroundSettings/GridContainer/SliderSFXVolume")

func _ready():
	master_slider.value = Save.game_data.master_vol
	music_slider.value = Save.game_data.music_vol
	sfx_slider.value = Save.game_data.sfx_vol


func _on_SliderMasterVolu_value_changed(value):
	GlobalSettings.update_master_vol(0, value)


func _on_SliderMusicVolu_value_changed(value):
	GlobalSettings.update_master_vol(1, value)


func _on_SliderSFXVolume_value_changed(value):
	GlobalSettings.update_master_vol(2, value)
