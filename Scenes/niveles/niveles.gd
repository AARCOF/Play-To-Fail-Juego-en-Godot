extends CanvasLayer

var scroll_container: ScrollContainer
var hbox_container: HBoxContainer
var current_index: int
var tween: Tween

onready var animationPlayer1: AnimationPlayer = $AnimationPlayer


func _ready():
	animationPlayer1.play("fondo_movimiento")
	scroll_container = get_node("ScrollContainer")
	hbox_container = scroll_container.get_node("HBoxContainer")
	current_index = 0
	
	
	# Crear el Tween y añadirlo al ScrollContainer
	tween = Tween.new()
	scroll_container.add_child(tween)
	prubita()

	
	
func _on_siguiente_pressed():
	current_index += 1

	if current_index >= hbox_container.get_child_count():
		current_index = 0

	var target_texture_rect = hbox_container.get_child(current_index)
	var target_position = target_texture_rect.rect_position.x

	tween.stop_all()
	tween.interpolate_property(scroll_container, "scroll_horizontal", scroll_container.scroll_horizontal, target_position, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()


func _on_anterior_pressed():
	
	current_index -= 1

	if current_index < 0:
		current_index = hbox_container.get_child_count() - 1

	var target_texture_rect = hbox_container.get_child(current_index)
	var target_position = target_texture_rect.rect_position.x

	tween.stop_all()
	tween.interpolate_property(scroll_container, "scroll_horizontal", scroll_container.scroll_horizontal, target_position, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()


func _on_Retroceder_tree_exited():
	$Retroceder.Home()


func prubita():
	print(globalVar.ALIAS)
	print(globalVar.obtainedPoint)
	print(globalVar.obtainedCoin)
