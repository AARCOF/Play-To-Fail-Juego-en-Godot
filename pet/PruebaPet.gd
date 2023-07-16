extends Node2D

onready var pet = $Pet
var timer = Timer.new()

func _ready():
	pet.starPet()
	
	timer.wait_time = 2.8
	timer.one_shot = true
	timer.connect("timeout", self, "_on_TIMER_timeout")
	add_child(timer)

func _on_START_pressed():
	pet.starPetHappy()
	timer.start()

func _on_OPTION_pressed():
	pet.starPet()

func _on_EXIT_pressed():
	pet.starPetSad()
	
func _on_TIMER_timeout():
	pet.starPet()
	# Aquí puedes realizar la otra acción después de los 2.8 segundos
	print("Otra acción después de los 2.8 segundos")
	# ...

# Fucion que interactua con el cursor
# ==================================
#onready var startButton = $START
#var buttonSize = Vector2()
#var screenWidth = 1024
#var screenHeight = 600
#var rango = 10

#func _ready():
	#pet.starPet()
	#buttonSize = startButton.rect_size


#func _process(delta):
#	actionMouse()

#func actionMouse():
#	var mousePos = get_viewport().get_mouse_position()

#	var buttonPos = startButton.rect_global_position
#	var buttonRect = Rect2(buttonPos, buttonSize)

#	var minX = buttonRect.position.x - rango
#	var maxX = buttonRect.position.x + buttonRect.size.x + rango
#	var minY = buttonRect.position.y - rango
#	var maxY = buttonRect.position.y + buttonRect.size.y + rango

#	if mousePos.x >= minX and mousePos.x <= maxX and mousePos.y >= minY and mousePos.y <= maxY:
#		action()
#	else:
#		undo_action()

#func action():
#	pet.starPetHappy()

#func undo_action():
#	pet.starPet()
