extends Camera2D

var dragging = false
var previous_position: Vector2 = Vector2(0, 0)


func _ready():
	set_process_input(true)
	
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
		


