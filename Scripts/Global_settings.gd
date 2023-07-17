extends Node

func update_master_vol(bus_idx, vol):
	AudioServer.set_bus_volume_db(bus_idx,vol if vol >= -50 else AudioServer.set_bus_mute(bus_idx,true))
	match bus_idx:
		0:
			Save.game_data.master_vol = vol
			Save.save_data()
		
		1:
			Save.game_data.music_vol = vol
			Save.save_data()

		2:
			Save.game_data.sfx_vol = vol
			Save.save_data()
