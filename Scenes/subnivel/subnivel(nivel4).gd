extends Control

onready var animationPlayer1: AnimationPlayer = $movimiento
onready var animationPlayer2: AnimationPlayer = $posiciones
onready var animationPlayer3: AnimationPlayer = $nube


func _ready():
	animationPlayer1.play("movimiento")
	animationPlayer3.play("nube")


func _on_Button_pressed():
	animationPlayer2.play("efecto1(btn1)")
	get_tree().change_scene("res://Scenes/levels/Nivel 4/nivel1.tscn")

func _on_Button2_pressed():
	animationPlayer2.play("efecto(btn2)")
	get_tree().change_scene("res://Scenes/levels/Nivel 4/nivel2.tscn")

func _on_Button3_pressed():
	animationPlayer2.play("efecto(btn3)")
	get_tree().change_scene("res://Scenes/levels/Nivel 4/nivel3.tscn")

func _on_Button4_pressed():
	animationPlayer2.play("efecto(btn4)")
	get_tree().change_scene("res://Scenes/levels/Nivel 4/nivel4.tscn")
