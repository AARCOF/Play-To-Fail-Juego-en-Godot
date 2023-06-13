extends Node2D

#Grid Variables
export (int) var width
export (int) var height
export (int) var x_start
export (int) var y_start
export (int) var offset

var possible_pieces = [
	preload("res://Scenes/piece_two.tscn"),
	preload("res://Scenes/piece_three.tscn"),
	preload("res://Scenes/piece_four.tscn"),
	preload("res://Scenes/piece_six.tscn"),
	preload("res://Scenes/piece_eigth.tscn"),
	preload("res://Scenes/piece_ten.tscn")
]

var all_pieces = []

func _ready():
	randomize()
	all_pieces = make_2d_array()
	spawn_pieces()

func make_2d_array():
	var array = []
	for i in width:
		array.append([])
		for j in height:
			array[i].append(null)
	return array

func spawn_pieces():
	for i in width:
		for j in height:
			#Elije un numero random
			var rand = floor(rand_range(0, possible_pieces.size()))
			#Instancia a la pieza del array
			var piece = possible_pieces[rand].instance()
			add_child(piece)
			piece.position = grid_to_pixel(i, j)

func grid_to_pixel(column, row):
		var new_x = x_start + offset * column
		var new_y = y_start + offset * row
		return Vector2(new_x, new_y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
