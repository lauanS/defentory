extends Camera2D

export var mouse_pos = Vector2()
var mouse_pos_global = Vector2()
var start = Vector2()
var start_v = Vector2()
var end = Vector2()
var end_v = Vector2()

var is_dragging = false

# var pathfinder
var move_to_point = Vector2()
signal start_move_selection

onready var rect_draw = $'../UI/Base/draw_react'

signal area_selected
func _ready():
	connect("area_selected", get_parent(), "area_selected", [self])
	connect("start_move_selection", get_parent(), "start_move_selection", [self])
	
func _process(delta):
	if Input.is_action_just_pressed("ui_left_mouse_button"):
		start = mouse_pos_global
		start_v = mouse_pos
		is_dragging = true
		
	if is_dragging:
		end = mouse_pos_global
		end_v = mouse_pos
		draw_area()
		
	if Input.is_action_just_released(("ui_left_mouse_button")):
		if start_v.distance_to(mouse_pos) > 50:
			end = mouse_pos_global
			end_v = mouse_pos
			is_dragging = false
			draw_area(false)
			emit_signal("area_selected")
		else:
			end = start
			is_dragging = false
			draw_area(false)
	
	if Input.is_action_just_released("ui_right_mouse_button"):
		move_to_point = mouse_pos_global
		emit_signal("start_move_selection")
		
func draw_area(s = true):
	rect_draw.rect_size = Vector2(abs(start_v.x-end_v.x), abs(start_v.y - end_v.y))
	
	var pos = Vector2()
	pos.x = min(start_v.x, end_v.x)
	pos.y = min(start_v.y, end_v.y)

	rect_draw.rect_position = pos
	
	rect_draw.rect_size *= int(s) # true = 1 and false = 0
	
func _input(event):
		if event is InputEventMouse:
			mouse_pos = event.position
			mouse_pos_global = get_global_mouse_position()