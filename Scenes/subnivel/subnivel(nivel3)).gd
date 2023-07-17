extends Control


onready var animationPlayer1: AnimationPlayer = $Animacionprincipal
onready var animationPlayer2: AnimationPlayer = $Animacionboton
onready var animationPlayer3: AnimationPlayer = $hoja


func _ready():
	animationPlayer1.play("sub")
	animationPlayer3.play("caidahoja")

func _on_bt1_pressed():
	animationPlayer2.play("nivel3(efecto1)")

func _on_bt2_pressed():
	animationPlayer2.play("nivel3(efecto2)")

func _on_bt3_pressed():
	animationPlayer2.play("nivel3(efecto3)")

func _on_bt4_pressed():
	animationPlayer2.play("nivel3(efecto4)")
