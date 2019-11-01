extends Camera2D

# Variaveis para controlar o movimento
var dragging = false
var previous_position: Vector2 = Vector2(0, 0)

# Variaveis para controlar o zoom
export var zoom_speed = 10

export var zoom_max = 2.0
export var zoom_min = 0.5

var zoom_pos = Vector2()
var zoom_factor = 1.5
var zooming = false

func _ready():
	set_process_input(true)
	
func _input(event):	
	if event is InputEventMouseButton:
		if event.is_pressed():
			zooming = true
			if event.button_index == BUTTON_WHEEL_UP:
				zoom_factor -= 0.1
				zoom_pos = get_global_mouse_position()
			if event.button_index == BUTTON_WHEEL_DOWN:
				zoom_factor += 0.1
				zoom_pos = get_global_mouse_position()
		else:
			zooming = false
				
func _unhandled_input(event):
	# Verificando se o evento eh o comando para movimentar a camera
	if event is InputEventMouseButton && event.button_index == BUTTON_LEFT:
		# Marcando como tratado o evento
		get_tree().set_input_as_handled();
		if event.is_pressed():
			previous_position = event.position
			dragging = true
		else:
			dragging = false
	elif event is InputEventMouseMotion && dragging:
    	get_tree().set_input_as_handled();
		# Efetivamente movendo a camera
    	position += (previous_position - event.position);
    	previous_position = event.position;

func set_zoom(delta):
	# Dando zoom
	zoom.x = lerp(zoom.x, zoom.x * zoom_factor, zoom_speed * delta)
	zoom.y = lerp(zoom.y, zoom.y * zoom_factor, zoom_speed * delta)
	
	# Impedindo que de mais zoom que o permitido
	zoom.x = clamp(zoom.x, zoom_min, zoom_max)
	zoom.y = clamp(zoom.y, zoom_min, zoom_max)
	
	# Impedindo que continue dando zoom sozinho
	# apos deixar de rolar o scroll do mouse
	if not zooming:
		zoom_factor = 1.0
				
func _process(delta):
	set_zoom(delta)
