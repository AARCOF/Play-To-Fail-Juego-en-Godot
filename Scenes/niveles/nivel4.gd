extends TextureRect


onready var animationPlayer1: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	animationPlayer1.play("nivel4(efecto)")
	


func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/subnivel/subnivel(nivel4).tscn")
