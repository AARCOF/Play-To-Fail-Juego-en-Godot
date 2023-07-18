extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var animationPlayer1: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_Button_pressed():
	$TextureRect6.visible = true
	animationPlayer1.play("candado")
	yield(get_tree().create_timer(2.0), "timeout")
	$TextureRect6.visible = false
