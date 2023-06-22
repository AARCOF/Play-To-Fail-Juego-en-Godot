extends Node2D

# Grid Variables
export (int) var width
export (int) var height
export (int) var x_start
export (int) var y_start
export (int) var offset

# Array de piezas
var possible_pieces = [
	preload("res://Scenes/piece_two.tscn"),
	preload("res://Scenes/piece_three.tscn"),
	preload("res://Scenes/piece_four.tscn"),
	preload("res://Scenes/piece_six.tscn"),
	preload("res://Scenes/piece_eigth.tscn"),
	preload("res://Scenes/piece_ten.tscn")
]

# Piezas en la escena
var all_pieces = []

# Interacción de las piezas
var first_touch = Vector2(0, 0)
var final_touch = Vector2(0, 0)
var controlling = false

func _ready():
	randomize()
	all_pieces = make_2d_array()
	spawn_pieces()

func make_2d_array():
	var array = []
	for i in range(width):
		array.append([])
		for j in range(height):
			array[i].append(null)
	return array

func spawn_pieces():
	for i in range(width):
		for j in range(height):
			var rand = rand_range(0, possible_pieces.size())
			var piece = possible_pieces[rand].instance()
			var loops = 0

			while (match_at(i, j, piece.color) && loops < 100):
				rand = rand_range(0, possible_pieces.size())
				loops += 1
				piece = possible_pieces[rand].instance()

			add_child(piece)
			piece.position = grid_to_pixel(i, j)
			piece.column = i
			piece.row = j
			all_pieces[i][j] = piece

func match_at(column, row, color):
	var is_match = false

	if column > 1:
		if all_pieces[column - 1][row] != null && all_pieces[column - 2][row] != null:
			if all_pieces[column - 1][row].color == color && all_pieces[column - 2][row].color == color:
				is_match = true
	if row > 1:
		if all_pieces[column][row - 1] != null && all_pieces[column][row - 2] != null:
			if all_pieces[column][row - 1].color == color && all_pieces[column][row - 2].color == color:
				is_match = true

	return is_match


func grid_to_pixel(column, row):
	var new_x = x_start + offset * column
	var new_y = y_start + offset * row
	return Vector2(new_x, new_y)

func pixel_to_grid(pixel_x, pixel_y):
	var new_x = round((pixel_x - x_start) / offset)
	var new_y = round((pixel_y - y_start) / offset)
	return Vector2(new_x, new_y)

func is_in_grid(grid_position):
	if grid_position.x >= 0 && grid_position.x < width:
		if grid_position.y >= 0 && grid_position.y < height:
			return true
	return false

func touch_input():
	if Input.is_action_just_pressed("ui_touch"):
		if is_in_grid(pixel_to_grid(get_global_mouse_position().x, get_global_mouse_position().y)):
			first_touch = pixel_to_grid(get_global_mouse_position().x, get_global_mouse_position().y)
			controlling = true
	if Input.is_action_just_released("ui_touch") && controlling:
		if is_in_grid(pixel_to_grid(get_global_mouse_position().x, get_global_mouse_position().y)) && controlling:
			controlling = false
			final_touch = pixel_to_grid(get_global_mouse_position().x, get_global_mouse_position().y )
			touch_difference(first_touch, final_touch)
			

func swap_pieces(column, row, direction):
	var first_piece = all_pieces[column][row]
	var other_piece = all_pieces[column + direction.x][row + direction.y]
	all_pieces[column][row] = other_piece
	all_pieces[column + direction.x][row + direction.y] = first_piece
	first_piece.move(grid_to_pixel(column + direction.x, row + direction.y))
	other_piece.move(grid_to_pixel(column, row))
	first_piece.column = column + direction.x
	first_piece.row = row + direction.y
	other_piece.column = column
	other_piece.row = row
	find_matches()

func touch_difference(grid_1, grid_2):
	var difference = grid_2 - grid_1
	if abs(difference.x) > abs(difference.y):
		if difference.x > 0:
			swap_pieces(grid_1.x, grid_1.y, Vector2(1, 0))
		elif difference.x < 0:
			swap_pieces(grid_1.x, grid_1.y, Vector2(-1, 0))
	elif abs(difference.y) > abs(difference.x):
		if difference.y > 0:
			swap_pieces(grid_1.x, grid_1.y, Vector2(0, 1))
		elif difference.y < 0:
			swap_pieces(grid_1.x, grid_1.y, Vector2(0, -1))

func _process(delta):
	touch_input()

func find_matches():
	for i in range(width):
		for j in range(height):
			if all_pieces[i][j] != null:
				var current_color = all_pieces[i][j].color
				#encuentra matches en el eje x
				if i > 0 && i < width - 1:
					if all_pieces[i - 1][j] != null && all_pieces[i + 1][j] != null:
						if all_pieces[i - 1][j].color == current_color && all_pieces[i + 1][j].color == current_color:
							all_pieces[i - 1][j].matched = true
							all_pieces[i - 1][j].dim()
							all_pieces[i][j].matched = true
							all_pieces[i][j].dim()
							all_pieces[i + 1][j].matched = true
							all_pieces[i + 1][j].dim()
				#encuentra matches en el eje y
				if j > 0 && j < height - 1:
					if all_pieces[i][j - 1] != null && all_pieces[i][j + 1] != null:
						if all_pieces[i][j - 1].color == current_color && all_pieces[i][j + 1].color == current_color:
							all_pieces[i][j - 1].matched = true
							all_pieces[i][j - 1].dim()
							all_pieces[i][j].matched = true
							all_pieces[i][j].dim()
							all_pieces[i][j + 1].matched = true
							all_pieces[i][j + 1].dim()
	get_parent().get_node("destroy_timer").start()
	
func destroy_matched():
	for i in range(width):
		for j in range(height):
			if all_pieces[i][j] != null:
				if all_pieces[i][j].matched:
					all_pieces[i][j].queue_free()
					all_pieces[i][j] = null
	get_parent().get_node("collapse_timer").start()
					
func collapse_columns():
	for i in range(width):
		for j in range(height):
			if all_pieces[i][j] == null:
				for k in range(j - 0.5, height):
					if all_pieces[i][k] != null:
						all_pieces[i][k].move(grid_to_pixel(i, j))
						all_pieces[i][j] = all_pieces[i][k]
						all_pieces[i][k] = null
						#print("ok")
						break

func _on_destroy_timer_timeout():
	destroy_matched()

func _on_collapse_timer_timeout():
	collapse_columns()
