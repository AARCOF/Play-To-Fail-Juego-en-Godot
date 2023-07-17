extends Node2D

#señal de eliminacion
signal remove_slime

#valores de la pantalla
var slime_pieces = []
var width = 8
var height = 10
var slime = preload("res://Scenes/slime.tscn")

func _ready():
	pass

func make_2d_array():
	var array = []
	for i in range(width):
		array.append([])
		for j in range(height):
			array[i].append(null)
	return array

func _on_grid_make_slime(board_position):
	if slime_pieces.size() == 0:
		slime_pieces = make_2d_array()
	var current = slime.instance()
	add_child(current)
	current.position = Vector2(board_position.x * 64 + 87, -board_position.y * 64 + 837)
	slime_pieces[board_position.x][board_position.y] = current

func _on_grid_damage_slime(board_position):
	if slime_pieces.size() != 0:
		if slime_pieces[board_position.x][board_position.y] != null:
			slime_pieces[board_position.x][board_position.y].take_damage(1)
			if slime_pieces[board_position.x][board_position.y].health <= 0:
				slime_pieces[board_position.x][board_position.y].queue_free()
				slime_pieces[board_position.x][board_position.y] = null
				emit_signal("remove_slime", board_position)
