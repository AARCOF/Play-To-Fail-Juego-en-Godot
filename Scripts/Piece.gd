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
	
	move_tween.interpolate_property(self, "position", position, target, 0.3, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
