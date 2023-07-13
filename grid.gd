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
export (PoolVector2Array) var lock_spaces
export (PoolVector2Array) var concrete_spaces
export (PoolVector2Array) var slime_pieces
var damaged_slime = false

# Seniales de obstaculos
signal make_block
signal damage_block
signal make_lock
signal damage_lock
signal make_concrete
signal damage_concrete
signal make_slime
signal damage_slime

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
	spawn_locks()
	spawn_concrete()
	spawn_slime()

func restricted_movement(place):
	if is_in_array(empty_spaces, place):
		return true
	if is_in_array(concrete_spaces, place):
		return true
	if is_in_array(slime_pieces, place):
		return true
	return false

func restricted_move(place):
	#Restringe el movimiento de las piezas 'licorice' y 'block'
	if is_in_array(lock_spaces, place):
		return true
	if is_in_array(block_spaces, place):
		return true
	return false

func is_in_array(array, item):
	for i in range(array.size()):
		if array[i] == item:
			return true
	return false

func remove_from_array(array, item):
	for i in range(array.size() - 1, -1, -1):
		if array[i] == item:
			array.remove(i)
	return array

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

func spawn_locks():
	for i in range(lock_spaces.size()):
		emit_signal("make_lock", lock_spaces[i])

func spawn_concrete():
	for i in range(concrete_spaces.size()):
		emit_signal("make_concrete", concrete_spaces[i])

func spawn_slime():
	for i in range(slime_pieces.size()):
		emit_signal("make_slime", slime_pieces[i])

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
		if !restricted_move(Vector2(column, row)) and !restricted_move(Vector2(column, row) + direction):
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
					if !is_piece_null(i - 1, j) && all_pieces[i + 1][j] != null:
						if all_pieces[i - 1][j].color == current_color && all_pieces[i + 1][j].color == current_color:
							match_and_dim(all_pieces[i + 1][j])
							match_and_dim(all_pieces[i][j])
							match_and_dim(all_pieces[i - 1][j])
							
				#encuentra matches en el eje y
				if j > 0 && j < height - 1:
					if !is_piece_null(i, j - 1) && all_pieces[i][j + 1] != null:
						if all_pieces[i][j - 1].color == current_color && all_pieces[i][j + 1].color == current_color:
							match_and_dim(all_pieces[i][j + 1])
							match_and_dim(all_pieces[i][j])
							match_and_dim(all_pieces[i][j - 1])
				variable_destroy = true
	get_parent().get_node("destroy_timer").start()

func is_piece_null(column, row):
	if all_pieces[column][row] == null:
		return true
	return false

func match_and_dim(item):
	item.matched = true
	item.dim()

func destroy_matched():
	var was_matched = false
	for i in range(width):
		for j in range(height):
			if all_pieces[i][j] != null:
				if all_pieces[i][j].matched:
					destroy_obstacles(i, j)
					was_matched = true
					all_pieces[i][j].queue_free()
					all_pieces[i][j] = null
		
	if was_matched:
		get_parent().get_node("collapse_timer").start()

func damage_array(array, column, row):
	if column < width - 1:
		emit_signal(array, Vector2(column + 1, row))
	if column > 0:
		emit_signal(array, Vector2(column - 1, row))
	if row < height - 1:
		emit_signal(array, Vector2(column, row + 1))
	if row > 0:
		emit_signal(array, Vector2(column, row - 1))

func check_slime(column, row):
	damage_array("damage_slime", column, row)

func check_concrete(column, row):
	damage_array("damage_concrete", column, row)

func check_lock(column, row):
	damage_array("damage_lock", column, row)

func destroy_obstacles(column, row):
	emit_signal("damage_block", Vector2(column, row))
	check_lock(column, row)
	check_concrete(column, row)
	check_slime(column, row)
	
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
	if !damaged_slime:
		generate_slime()
		
	state = move
	move_checked = false
	damaged_slime = false

func generate_slime():
	if slime_pieces.size() > 0:
		var slime_made = false
		var  tracker = 0
		while !slime_made and tracker < 100:
			var random_num = floor(rand_range(0, slime_pieces.size()))
			var curr_x = slime_pieces[random_num].x
			var curr_y = slime_pieces[random_num].y
			var neighbor = find_normal_neighbor(curr_x, curr_y)
			if neighbor != null:
				all_pieces[neighbor.x][neighbor.y].queue_free()
				all_pieces[neighbor.x][neighbor.y] = null

				slime_pieces.append(Vector2(neighbor.x, neighbor.y))
				emit_signal("make_slime", Vector2(neighbor.x, neighbor.y))
				slime_made = true

		tracker += 1

func find_normal_neighbor(column, row):
	if is_in_grid(Vector2(column + 1, row)):
		if all_pieces[column + 1][row] != null:
			return Vector2(column + 1, row)
			
	if is_in_grid(Vector2(column - 1, row)):
		if all_pieces[column - 1][row] != null:
			return Vector2(column - 1, row)

	if is_in_grid(Vector2(column, row + 1)):
		if all_pieces[column][row + 1] != null:
			return Vector2(column, row + 1)
					
	if is_in_grid(Vector2(column, row - 1)):
		if all_pieces[column][row - 1] != null:
			return Vector2(column, row - 1)
	
	return null

func _on_destroy_timer_timeout():
	if variable_destroy:
		#No borrar, impide que el swapback se ejecute luego de un match
		if !move_checked:
			destroy_matched()
			swap_back()
			print("SwapBack")
			variable_destroy = false
		else:
			move_checked = false
			variable_destroy = true
			state = move	

func _on_collapse_timer_timeout():
	collapse_columns()
	print("Collapse")

func _on_refill_timer_timeout():
	refill_colums()
	print("refill")
	
func _on_lock_holder_remove_lock(place):
	lock_spaces = remove_from_array(lock_spaces, place)

func _on_block_holder_remove_block(place):
	block_spaces = remove_from_array(block_spaces, place)

func _on_concrete_holder_remove_concrete(place):
	concrete_spaces = remove_from_array(concrete_spaces, place)

func _on_slime_holder_remove_slime(place):
	damaged_slime = true
	slime_pieces = remove_from_array(slime_pieces, place)
