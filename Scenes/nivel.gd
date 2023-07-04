extends Control

var carouselContainer: HBoxContainer
var currentIndex: int = 0
var animationDuration: float = 0.5
var animationEase: int = 2  # Utilizar 2 para la transición cúbica
var tween: Tween

func _ready():
	carouselContainer = $HBoxContainer
	tween = Tween.new()
	add_child(tween)

func move_left():
	currentIndex -= 1
	if currentIndex < 0:
		currentIndex = carouselContainer.get_child_count() - 1
	update_carousel_position()

func move_right():
	currentIndex += 1
	if currentIndex >= carouselContainer.get_child_count():
		currentIndex = 0
	update_carousel_position()

func update_carousel_position():
	var spacing = 50  # Espaciado entre las imágenes
	
	for i in range(carouselContainer.get_child_count()):
		var child = carouselContainer.get_child(i)
		var targetPos = (i - currentIndex) * (child.get_size().x + spacing)
		
		# Aplicar animación de desplazamiento
		tween.interpolate_property(child, "rect_position", child.get_position(), Vector2(targetPos, child.get_position().y), animationDuration, animationEase)
		tween.start()

func _on_anterior_pressed():
	move_left()

func _on_siguiente_pressed():
	move_right()
	   
