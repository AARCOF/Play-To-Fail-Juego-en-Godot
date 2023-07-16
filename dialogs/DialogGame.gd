extends Node2D

onready var pet = $Pet
var textSpeed = 0.01
var counter = 1

func _ready():
	pet.starPet()

func _on_next_pressed():
	if (counter == 1) :
		hide()
	else :
		print ("varias veces")

func setMessage(TEXT: String) -> void:
	show()

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

# Para varios mensajes
func plusMessage(number:int, TEXT: String) -> void:
	counter = number
	pass
#func starPet():

#func starPetHappy():

#func starPetSad():

