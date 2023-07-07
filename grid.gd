extends Node2D

# State Machine
enum{wait, move}
var state

# Grid Variables
export (int) var width
export (int) var height
export (int) var x_start
export (int) var y_start
export (int) var offset
export (int) var y_offset

# Obstaculos
export (PoolVector2Array) var empty_spaces
export (PoolVector2Array) var block_spaces

# Seniales de obstaculos
signal make_block
signal damage_block

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

# Variables para el Swap Back
var piece_one = null
var piece_two = null
var last_place = Vector2(0, 0)
var last_direction = Vector2(0, 0)
var move_checked = false
var variable_destroy = false

# Interacción de las piezas
var first_touch = Vector2(0, 0)
var final_touch = Vector2(0, 0)
var controlling = false

func _ready():
	state = move
	randomize()
	all_pieces = make_2d_array()
	spawn_pieces()
	spawn_block()

func restricted_movement(place):
	for i in empty_spaces.size():
		if empty_spaces[i] == place:
			return true
	return false
	
func make_2d_array():
	var array = []
	for i in width:
		array.append([])
		for j in height:
			array[i].append(null)
	return array

func spawn_pieces():
	for i in range(width):
		for j in range(height):
			if !restricted_movement(Vector2(i, j)) && all_pieces[i][j] == null:
				var rand = floor(rand_range(0, possible_pieces.size()))
				var loops = 0
				var piece = possible_pieces[rand].instance()

				while (match_at(i, j, piece.color) && loops < 100):
					rand = rand_range(0, possible_pieces.size())
					loops += 1
					piece = possible_pieces[rand].instance()

				add_child(piece);
				piece.position = grid_to_pixel(i, j)
				all_pieces[i][j] = piece

func spawn_block():
	for i in range(block_spaces.size()):
		emit_signal("make_block", block_spaces[i])

func match_at(i, j, color):
	if i > 1:
		if all_pieces[i-1][j] != null && all_pieces[i-2][j] != null:
			if all_pieces[i - 1][j].color == color && all_pieces[i - 2][j].color == color:
				return true
	
	if j > 1:
		if all_pieces[i][j-1] != null && all_pieces[i][j-2] != null:
			if all_pieces[i][j-1].color == color && all_pieces[i][j-2].color == color:
				return true

func grid_to_pixel(column, row):
	var new_x = x_start + offset * column
	var new_y = y_start + -offset * row
	return Vector2(new_x, new_y);

func pixel_to_grid(pixel_x, pixel_y):
	var new_x = round((pixel_x - x_start) / offset)
	var new_y = round((pixel_y - y_start) / -offset)
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
			
	if Input.is_action_just_released("ui_touch"):
		if is_in_grid(pixel_to_grid(get_global_mouse_position().x, get_global_mouse_position().y)) && controlling:
			controlling = false;
			final_touch = pixel_to_grid(get_global_mouse_position().x, get_global_mouse_position().y)
			touch_difference(first_touch, final_touch)

func swap_pieces(column, row, direction):
	var first_piece = all_pieces[column][row]
	var other_piece = all_pieces[column + direction.x][row + direction.y]
	if first_piece != null && other_piece != null:
		restore_info(first_piece, other_piece, Vector2(column, row), direction)
		state = wait
		all_pieces[column][row] = other_piece
		all_pieces[column + direction.x][row + direction.y] = first_piece
		first_piece.move(grid_to_pixel(column + direction.x, row + direction.y))
		other_piece.move(grid_to_pixel(column, row))

		if !move_checked:
			find_matches()

func restore_info(first_piece, other_piece, place, direction):
	piece_one = first_piece
	piece_two = other_piece
	last_place = place
	last_direction = direction
	pass

func swap_back():
	if piece_one != null && piece_two != null:
		swap_pieces(last_place.x, last_place.y, last_direction) 
		state = move
		move_checked = false

	piece_one = null
	piece_two = null
	

func touch_difference(grid_1, grid_2):
	var difference = grid_2 - grid_1;
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
	if state == move:
		touch_input()

func find_matches():
	for i in width:
		for j in height:
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
				variable_destroy = true
	get_parent().get_node("destroy_timer").start()
		
func destroy_matched():
	var was_matched = false
	for i in range(width):
		for j in range(height):
			if all_pieces[i][j] != null:
				if all_pieces[i][j].matched:
					emit_signal("damage_block", Vector2(i, j))
					was_matched = true
					all_pieces[i][j].queue_free()
					all_pieces[i][j] = null
		
	if was_matched:
		get_parent().get_node("collapse_timer").start()

func collapse_columns():
	for i in width:
		for j in height:
			if all_pieces[i][j] == null && !restricted_movement(Vector2(i, j)):
				for k in range(j + 1, height):
					if all_pieces[i][k] != null:
						all_pieces[i][k].move(grid_to_pixel(i, j))
						all_pieces[i][j] = all_pieces[i][k]
						all_pieces[i][k] = null
						break
	get_parent().get_node("refill_timer").start()

func refill_colums():
	for i in width:
		for j in height:
			if all_pieces[i][j] == null && !restricted_movement(Vector2(i, j)):
				var rand = floor(rand_range(0, possible_pieces.size()))
				var piece = possible_pieces[rand].instance()
				var loops = 0
				while(match_at(i, j, piece.color) && loops < 100):
					rand = floor(rand_range(0, possible_pieces.size()))
					loops += 1
					piece = possible_pieces[rand].instance()
				
				add_child(piece);
				piece.position = grid_to_pixel(i, j + y_offset)
				piece.move(grid_to_pixel(i,j))
				all_pieces[i][j] = piece
	after_refill()

func after_refill():
	for i in range(width):
		for j in range(height):
			if all_pieces[i][j] != null:
				if match_at(i, j, all_pieces[i][j].color) and all_pieces[i][j].matched:
					find_matches()
					variable_destroy = true
					if variable_destroy:
						get_parent().get_node("destroy_timer").start()
						variable_destroy = false				
	state = move
	move_checked = true

func _on_destroy_timer_timeout():
	if variable_destroy:
		#No borrar, impide que el swapback se ejecute luego de un match
		if !move_checked:
			destroy_matched()
			swap_back()
			print("SwapBack")
		else:
			move_checked = false
			variable_destroy = false
			state = move	

func _on_collapse_timer_timeout():
	collapse_columns()
	print("Collapse")

func _on_refill_timer_timeout():
	refill_colums()
	print("refill")
