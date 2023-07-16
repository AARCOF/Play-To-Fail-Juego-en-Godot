extends KinematicBody2D

onready var animationPlayer = $AnimationPlayer
onready var sprite = $AnimationPlayer/Animation


func starPet():
	$AnimationPlayer/Moving.visible = true
	$AnimationPlayer/Happy.visible = false
	$AnimationPlayer/Sad.visible = false
	sprite.play("moving")

func starPetHappy():
	$AnimationPlayer/Moving.visible = false
	$AnimationPlayer/Happy.visible = true
	$AnimationPlayer/Sad.visible = false
	sprite.play("happy")
	
func starPetSad():
	$AnimationPlayer/Moving.visible = false
	$AnimationPlayer/Happy.visible = false
	$AnimationPlayer/Sad.visible = true
	sprite.play("sad")
