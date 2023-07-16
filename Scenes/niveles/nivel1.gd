extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var animationPlayer1: AnimationPlayer = $TextureRect4/AnimatedSprite/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	animationPlayer1.play("a")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/subnivel/Subnivel(nivel1).tscn")
