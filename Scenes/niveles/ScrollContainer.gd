extends ScrollContainer

var is_dragging = false
var drag_start = Vector2()

func _input(event):
	if event is InputEventScreenTouch:
		if event.phase == InputEventScreenTouch.PRESSED:
			is_dragging = true
			drag_start = event.position
			set_process_input(true)
		elif event.phase == InputEventScreenTouch.MOTION and is_dragging:
			var delta = event.position - drag_start
			scroll_offset -= delta
			drag_start = event.position
		elif event.phase == InputEventScreenTouch.RELEASED and is_dragging:
			is_dragging = false
			set_process_input(false)



