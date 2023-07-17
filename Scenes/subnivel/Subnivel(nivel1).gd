extends Control


onready var animationPlayer1: AnimationPlayer = $AnimationPlayer2
onready var animationPlayer2: AnimationPlayer = $AnimationPlayer


func _ready():
	animationPlayer2.play("subnivel 1")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	animationPlayer1.play("efecto(1)")


func _on_Button2_pressed():
	animationPlayer1.play("efecto(2)")


func _on_Button3_pressed():
	animationPlayer1.play("efecto(3)")


func _on_Button4_pressed():
	animationPlayer1.play("efecto(4)")
