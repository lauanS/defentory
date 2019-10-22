extends Camera2D

export var speed = 15.0
export var zoom_margin = 0.1
export var zoom_speed = 10

export var zoom_max = 2.0
export var zoom_min = 0.5

var zoom_pos = Vector2()
var zoom_factor = 1.5

func _ready():
	pass # Replace with function body.

func _input(event):
	if abs(zoom_pos.x - get_global_mouse_position().x) > zoom_margin:
		zoom_factor = 1.0
	if abs(zoom_pos.y - get_global_mouse_position().y) > zoom_margin:
		zoom_factor = 1.0
	
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_WHEEL_UP:
				zoom_factor -= 0.1
				zoom_pos = get_global_mouse_position()
			if event.button_index == BUTTON_WHEEL_DOWN:
				zoom_factor += 0.1
				zoom_pos = get_global_mouse_position()

	
	
	
func _process(delta):
	# Definindo o movimento para os lados
	var input_right = int(Input.is_action_pressed("ui_right"))
	var input_left = int(Input.is_action_pressed("ui_left"))
	var input_x =  input_right - input_left
	
	# Definindo o movimento para cima e para baixo
	var input_down = int(Input.is_action_pressed("ui_down"))
	var input_up = int(Input.is_action_pressed("ui_up"))
	var input_y =  input_down - input_up
	
	# Movimentando
	position.x = lerp(position.x, position.x + input_x * speed * zoom.x, speed * delta)
	position.y = lerp(position.y, position.y + input_y * speed * zoom.y, speed * delta)
	
	zoom.x = lerp(zoom.x, zoom.x * zoom_factor, zoom_speed * delta)
	zoom.y = lerp(zoom.y, zoom.y * zoom_factor, zoom_speed * delta)
	
	zoom.x = clamp(zoom.x, zoom_min, zoom_max)
	zoom.y = clamp(zoom.y, zoom_min, zoom_max)