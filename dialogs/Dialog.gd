extends CanvasLayer

var textSpeed = 0.01


func showDialog(TEXT: String) -> void:
	show()

	$Control/Text.bbcode_text = "[color=#6E2C00]" + TEXT
	$Control/Text.percent_visible = 0
	
	var tweeDuration = textSpeed * TEXT.length()
	
	#Animation text
	$Control/Tween.interpolate_property(
		$Control/Text, "percent_visible",0,1,tweeDuration,
		Tween.TRANS_LINEAR,Tween.EASE_IN_OUT
	)
	$Control/Tween.start()
	
	$Control/AudioStreamPlayer.play(1-tweeDuration)


func _on_Button_pressed():
	hide()
