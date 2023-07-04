extends NinePatchRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
onready var animationPlayerx: AnimationPlayer = $letra_x/AnimationPlayer
onready var animationPlayer8: AnimationPlayer = $numero_8/AnimationPlayer
onready var animationPlayer6: AnimationPlayer = $numero_6/AnimationPlayer
onready var animationPlayer7: AnimationPlayer = $numero_7/AnimationPlayer
onready var animationPlayer5: AnimationPlayer = $numero_5/AnimationPlayer
onready var animationPlayer3: AnimationPlayer = $numero_3/AnimationPlayer
onready var animationPlayer1: AnimationPlayer = $numero_1/AnimationPlayer

func _ready():
	# Reproducir la animación en bucle
	animationPlayerx.play("mover_x")
	animationPlayer8.play("mover_8")
	animationPlayer6.play("mover_6")
	animationPlayer7.play("mover_7")
	animationPlayer5.play("mover_5")
	animationPlayer3.play("mover_3")
	animationPlayer1.play("mover_1")
	


