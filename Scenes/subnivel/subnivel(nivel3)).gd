extends Control


onready var animationPlayer1: AnimationPlayer = $Animacionprincipal
onready var animationPlayer2: AnimationPlayer = $Animacionboton
onready var animationPlayer3: AnimationPlayer = $hoja


func _ready():
	animationPlayer1.play("subnivel 1")
	animationPlayer3.play("caidahoja")

func _on_bt1_pressed():
	animationPlayer2.play("nivel3(efecto1)")
	get_tree().change_scene("res://Scenes/levels/Nivel 3/nivel1.tscn")
func _on_bt2_pressed():
	animationPlayer2.play("nivel3(efecto2)")
	get_tree().change_scene("res://Scenes/levels/Nivel 3/nivel2.tscn")
func _on_bt3_pressed():
	animationPlayer2.play("nivel3(efecto3)")
	get_tree().change_scene("res://Scenes/levels/Nivel 3/nivel3.tscn")
func _on_bt4_pressed():
	animationPlayer2.play("nivel3(efecto4)")
	get_tree().change_scene("res://Scenes/levels/Nivel 3/nivel4.tscn")
