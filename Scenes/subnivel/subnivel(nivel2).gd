extends Control

onready var animationPlayer1: AnimationPlayer = $AnimationPlayer
onready var animationPlayer2: AnimationPlayer = $Animacion
onready var animationPlayer3: AnimationPlayer = $AnimationPlayer2

func _ready():
	animationPlayer1.play("subnivel 1")
	animationPlayer3.play("estrellafugaz")


func _on_btn1_pressed():
	animationPlayer2.play("efecto(2.1)")


func _on_btn2_pressed():
	animationPlayer2.play("efecto(2.2)")


func _on_btn3_pressed():
	animationPlayer2.play("efecto(2.3)")


func _on_btn4_pressed():
	animationPlayer2.play("efecto(2.4)")
