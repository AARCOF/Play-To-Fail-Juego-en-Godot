extends KinematicBody2D

onready var animationPlayer = $AnimationPlayer
onready var sprite = $AnimationPlayer/Animation

func _ready():
	pass
	
func starPet():
	$AnimationPlayer/Moving.visible = true
	$AnimationPlayer/Happy.visible = false
	$AnimationPlayer/Sad.visible = false
	sprite.play("moving")

func starPetHappy():
	$AnimationPlayer/Happy.visible = true
	$AnimationPlayer/Moving.visible = false
	$AnimationPlayer/Sad.visible = false
	sprite.play("happy")
	
func starPetSad():
	$AnimationPlayer/Sad.visible = true
	$AnimationPlayer/Moving.visible = false
	$AnimationPlayer/Happy.visible = false
	sprite.play("sad")


func starPetHappyOne():
	$AnimationPlayer/Happy.visible = true
	$AnimationPlayer/Moving.visible = false
	$AnimationPlayer/Sad.visible = false
	sprite.play("happy")
	yield(get_tree().create_timer(1.4), "timeout")
	sprite.stop()
	starPet()
	
