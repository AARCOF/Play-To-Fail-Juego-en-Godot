extends Node2D

onready var pet = $Pet
var textSpeed = 0.01

var counter = 1
var messages = []

func _ready():
	pass
	
func _on_next_pressed():
	if (messages.size() == null) :
		hide()
	else :
		if ( counter < messages.size() ) :
			setMessage(str(messages[counter]))
			counter = counter + 1
		else:
			hide()


func setMessage(TEXT: String) -> void:
	show()
	pet.starPetHappyOne()

	$Control/text.bbcode_text = "[color=#6E2C00]" + TEXT
	$Control/text.percent_visible = 0
	
	var tweeDuration = textSpeed * TEXT.length()
	
	#Animation text
	$Control/Tween.interpolate_property(
		$Control/text, "percent_visible",0,1,tweeDuration,
		Tween.TRANS_LINEAR,Tween.EASE_IN_OUT
	)
	$Control/Tween.start()
	#$Control/AudioStreamPlayer.play(1-tweeDuration)


func arrayMessages(vect: Array) -> void:
	messages = vect
