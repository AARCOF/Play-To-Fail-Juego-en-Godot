extends Node2D
var column: float = 0
var row: float = 0
#var vec = Vector2(column, row)
export (String) var color
var move_tween
 
# Called when the node enters the scene tree for the first time.
func _ready():
	move_tween = get_node("move_tween")

func move(target):
	#función de la animación de piezas. Aquí también se puede añadir sonido depende al movimiento que se realice.
	move_tween.interpolate_property(self, "position", position, target, 0.3, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	move_tween.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
