extends Control


onready var animationPlayer1: AnimationPlayer = $AnimationPlayer2
onready var animationPlayer2: AnimationPlayer = $AnimationPlayer


func _ready():
	animationPlayer2.play("subnivel 1")
	$TextureRect6/AnimatedSprite.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	animationPlayer1.play("efecto(1)")
	
	#ADD ALGORITHM
	#yield(get_tree().create_timer(3.0), "timeout")
	animationPlayer1.stop()
	get_tree().change_scene("res://Scenes/levels/Nivel 1/nivel1.tscn")
	$TextureRect6/AnimatedSprite.stop()
	
func _on_Button2_pressed():
	animationPlayer1.play("efecto(2)")
	get_tree().change_scene("res://Scenes/levels/Nivel 1/nivel2.tscn")

	$TextureRect6/AnimatedSprite.stop()


func _on_Button3_pressed():
	animationPlayer1.play("efecto(3)")
	get_tree().change_scene("res://Scenes/levels/Nivel 1/nivel3.tscn")
	$TextureRect6/AnimatedSprite.stop()


func _on_Button4_pressed():
	animationPlayer1.play("efecto(4)")
	get_tree().change_scene("res://Scenes/levels/Nivel 1/nivel4.tscn")
	$TextureRect6/AnimatedSprite.stop()
