extends Node2D

var block_pieces = []
var width = 8
var height = 10
var block = preload("res://Scenes/block.tscn")

func _ready():
	block_pieces = make_2d_array()

func make_2d_array():
	var array = []
	for i in range(width):
		array.append([])
		for j in range(height):
			array[i].append(null)
	return array

func _on_grid_make_block(board_position):
	if block_pieces.size() == 0:
		block_pieces = make_2d_array()
	var current = block.instance()
	add_child(current)
	current.position = Vector2(board_position.x * 64 + 87, -board_position.y * 64 + 837)
	block_pieces[board_position.x][board_position.y] = current

func _on_grid_damage_block(board_position):
	if block_pieces[board_position.x][board_position.y] != null:
		block_pieces[board_position.x][board_position.y].take_damage(1)
		if block_pieces[board_position.x][board_position.y].health == 0:
			block_pieces[board_position.x][board_position.y].queue_free()
			block_pieces[board_position.x][board_position.y] = null
