extends Camera2D

export var speed = 10.0

func _ready():
	pass # Replace with function body.


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
	position.x += input_x * speed
	position.y += input_y * speed
	
