extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.

var speed: float = 40
var direction: int = 1

func _physics_process(delta: float) -> void:
	var position = $ParallaxBackground/ParallaxLayer/Imagen1.position
	position.y += speed * direction * delta

	# Verificar si la imagen ha alcanzado la posición límite superior o inferior
	if position.y >= 350:  # Reemplaza "300" con la posición límite superior deseada
		direction = -1
	elif position.y <= 300:  # Reemplaza "100" con la posición límite inferior deseada
		direction = 1

	$ParallaxBackground/ParallaxLayer/Imagen1.position = position
