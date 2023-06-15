extends Node2D

export (String) var color
var move_tween
# Called when the node enters the scene tree for the first time.
func _ready():
	move_tween = get_node("move_tween")

func move(target):
	move_tween.interpolate.property(self, "position", position, target, .3, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	move_tween.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
