extends CanvasLayer

var scroll_container: ScrollContainer
var hbox_container: HBoxContainer
var current_index: int
var tween: Tween


onready var nivel1: AnimationPlayer = $ScrollContainer/HBoxContainer/nivel1/TextureRect4/AnimatedSprite/AnimationPlayer
onready var sprite1: AnimatedSprite = $ScrollContainer/HBoxContainer/nivel1/TextureRect4/AnimatedSprite
onready var nivel2: AnimationPlayer = $ScrollContainer/HBoxContainer/nivel2/TextureRect4/AnimatedSprite/AnimationPlayer
onready var sprite2: AnimatedSprite = $ScrollContainer/HBoxContainer/nivel2/TextureRect4/AnimatedSprite
onready var nivel3: AnimationPlayer = $ScrollContainer/HBoxContainer/nivel3/AnimationPlayer
onready var sprite3: AnimatedSprite = $ScrollContainer/HBoxContainer/nivel3/TextureRect4/AnimatedSprite
onready var nivel4: AnimationPlayer = $ScrollContainer/HBoxContainer/nivel4/AnimationPlayer
onready var sprite4: AnimatedSprite = $ScrollContainer/HBoxContainer/nivel4/TextureRect4/AnimatedSprite


func _ready():
	
	scroll_container = get_node("ScrollContainer")
	hbox_container = scroll_container.get_node("HBoxContainer")
	current_index = 0
	
	# Crear el Tween y añadirlo al ScrollContainer
	tween = Tween.new()
	scroll_container.add_child(tween)

	
	
func _on_siguiente_pressed():
	current_index += 1
	
	if current_index==0 or current_index==5:
		sprite1.play()
		nivel1.play()
		sprite2.stop()
		nivel2.stop()
		sprite3.stop()
		nivel3.stop()
		sprite4.stop()
		nivel4.stop()
	elif current_index == 1:
		sprite1.stop()
		nivel1.stop()
		sprite2.play()
		nivel2.play()
		sprite3.stop()
		nivel3.stop()
		sprite4.stop()
		nivel4.stop()
	elif current_index == 2:
		sprite1.stop()
		nivel1.stop()
		sprite2.stop()
		nivel2.stop()
		sprite3.play()
		nivel3.play()
		sprite4.stop()
		nivel4.stop()
	elif current_index == 3:
		sprite1.stop()
		nivel1.stop()
		sprite2.stop()
		nivel2.stop()
		sprite3.stop()
		nivel3.stop()
		sprite4.play()
		nivel4.play()	

	if current_index >= hbox_container.get_child_count():
		current_index = 0

	var target_texture_rect = hbox_container.get_child(current_index)
	var target_position = target_texture_rect.rect_position.x

	tween.stop_all()
	tween.interpolate_property(scroll_container, "scroll_horizontal", scroll_container.scroll_horizontal, target_position, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()


func _on_anterior_pressed():
	
	current_index -= 1
	if current_index==0 or current_index==5:
		sprite1.play()
		nivel1.play()
		sprite2.stop()
		nivel2.stop()
		sprite3.stop()
		nivel3.stop()
		sprite4.stop()
		nivel4.stop()
	elif current_index == 1:
		sprite1.stop()
		nivel1.stop()
		sprite2.play()
		nivel2.play()
		sprite3.stop()
		nivel3.stop()
		sprite4.stop()
		nivel4.stop()
	elif current_index == 2:
		sprite1.stop()
		nivel1.stop()
		sprite2.stop()
		nivel2.stop()
		sprite3.play()
		nivel3.play()
		sprite4.stop()
		nivel4.stop()
	elif current_index == 3:
		sprite1.stop()
		nivel1.stop()
		sprite2.stop()
		nivel2.stop()
		sprite3.stop()
		nivel3.stop()
		sprite4.play()
		nivel4.play()		
	if current_index < 0:
		current_index = hbox_container.get_child_count() - 1

	var target_texture_rect = hbox_container.get_child(current_index)
	var target_position = target_texture_rect.rect_position.x

	tween.stop_all()
	tween.interpolate_property(scroll_container, "scroll_horizontal", scroll_container.scroll_horizontal, target_position, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()


func _on_Retroceder_tree_exited():
	$Retroceder.Home()



func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/home/home.tscn")
