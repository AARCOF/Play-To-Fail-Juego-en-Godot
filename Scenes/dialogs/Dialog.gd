extends CanvasLayer

var textSpeed = 0.01

signal button_pressed

func _ready():
	$Control/Button/AnimationPlayer.stop(true)
	$Control/Sprite/AnimationPlayer.stop(true)
	$Control/AudioStreamPlayer.stop()
	
func showDialog(TEXT: String) -> void:
	show()
	starAnimation()

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
	$Control/Button/AnimationPlayer.stop(true)
	$Control/Sprite/AnimationPlayer.stop(true)
	
	
func starAnimation() -> void:
	$Control/Button/AnimationPlayer.play("NEXT")
	$Control/Sprite/AnimationPlayer.play("motion")
	
