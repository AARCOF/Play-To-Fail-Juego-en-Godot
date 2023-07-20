extends KinematicBody2D


func _ready():
	pass


func starPet():
	$CollisionShape2D/Animated.visible = true
	$CollisionShape2D/Animated/AnimationPlayer.play("moving")
	
	
	
func stopPet():
	$CollisionShape2D/Animated.visible = false
	$CollisionShape2D/Animated/AnimationPlayer.stop()
	
