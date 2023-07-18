extends Node2D
var column: float = 0
var row: float = 0
var vec = Vector2(column, row)

export (String) var color
export (Texture) var row_texture
export (Texture) var column_texture
export (Texture) var adjacent_texture

var is_row_bomb = false
var is_column_bomb = false
var is_adjacent_bomb = false 

var move_tween
var matched = false 
 
# Called when the node enters the scene tree for the first time.
func _ready():
	move_tween = get_node("move_tween")

func move(target):
	#función de la animación de piezas. Aquí también se puede añadir sonido depende al movimiento que se realice.
	move_tween.interpolate_property(self, "position", position, target, .3, Tween.TRANS_BACK, Tween.EASE_OUT)
	move_tween.start()

func make_column_bomb():
	is_column_bomb = true
	$Sprite.texture = column_texture
	$Sprite.modulate = Color(1, 1, 1, 1)

func make_row_bomb():
	is_row_bomb = true
	$Sprite.texture = row_texture
	$Sprite.modulate = Color(1, 1, 1, 1)

func make_adjacent_bomb():
	is_adjacent_bomb = true
	$Sprite.texture = adjacent_texture
	$Sprite.modulate = Color(1, 1, 1, 1)

func dim():
	var sprite = get_node("Sprite")
	sprite.modulate = Color(1, 1, 1, .5)

