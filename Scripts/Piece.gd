extends Node2D
var column: float = 0
var row: float = 0
#var vec = Vector2(column, row)
export (String) var color
var move_tween
var matched = false 
 
# Called when the node enters the scene tree for the first time.
func _ready():
	move_tween = get_node("move_tween")

func move(target):
	#función de la animación de piezas. Aquí también se puede añadir sonido depende al movimiento que se realice.
	move_tween.interpolate_property(self, "position", position, target, 0.3, Tween.TRANS_BACK, Tween.EASE_OUT)
	move_tween.start()

func dim():
	var sprite = get_node("Sprite")
	sprite.modulate = Color(1, 1, 1, 0.5)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
