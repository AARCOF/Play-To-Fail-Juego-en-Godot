extends Control


onready var animationPlayer1: AnimationPlayer = $Animacionprincipal
onready var animationPlayer2: AnimationPlayer = $Animacionboton
onready var animationPlayer3: AnimationPlayer = $hoja


func _ready():
	animationPlayer1.play("subnivel 1")
	animationPlayer3.play("caidahoja")
	$TextureRect6/AnimatedSprite.play()

func _on_bt1_pressed():
	animationPlayer2.play("nivel3(efecto1)")
	$TextureRect6/AnimatedSprite.stop()

func _on_bt2_pressed():
	animationPlayer2.play("nivel3(efecto2)")
	$TextureRect6/AnimatedSprite.stop()

func _on_bt3_pressed():
	animationPlayer2.play("nivel3(efecto3)")
	$TextureRect6/AnimatedSprite.stop()

func _on_bt4_pressed():
	animationPlayer2.play("nivel3(efecto4)")
	$TextureRect6/AnimatedSprite.stop()
