extends Camera2D

# Variaveis para selecao de unidades
export var mouse_pos = Vector2()
var mouse_pos_global = Vector2()
var start = Vector2()
var start_v = Vector2()
var end = Vector2()
var end_v = Vector2()

var is_dragging = false

# variaveis para pathfinder
var move_to_point = Vector2()

signal area_selected
signal start_move_selection

onready var rect_draw = $'../UI/Base/draw_react'

func _ready():
	# Conectando com os sinais
	connect("area_selected", get_parent(), "area_selected", [self])
	connect("start_move_selection", get_parent(), "start_move_selection", [self])
	
func _process(delta):
	# Obtendo a posicao inicial ao desenhar a area
	if Input.is_action_just_pressed("ui_left_mouse_button"):
		start = mouse_pos_global
		start_v = mouse_pos
		is_dragging = true
		
	# Atualizando a posicao final e desenahndo o retangulo
	if is_dragging:
		end = mouse_pos_global
		end_v = mouse_pos
		draw_area()
		
	# Verifica se deve parar de desenhar o retangulo
	if Input.is_action_just_released(("ui_left_mouse_button")):
		# Verifica se pessoa movimentou o mouse uma quantia
		# suficiente para ser considerada
		if start_v.distance_to(mouse_pos) > 50:
			# Se mouve o mouse suficientemente, atualiza a posicao final
			end = mouse_pos_global
			end_v = mouse_pos
			# Termina de desenhar o retangulo
			is_dragging = false
			draw_area(false)
			# Avisa para os ouvintes que uma area foi selecionada
			emit_signal("area_selected")
		else:
			# Se nao mouve o mouse suficientemente
			# Apaga o retangulo
			end = start
			is_dragging = false
			draw_area(false)
	
	# Verifica se recebemos o comando para movimentar as unidades
	if Input.is_action_just_released("ui_right_mouse_button"):
		move_to_point = mouse_pos_global
		emit_signal("start_move_selection")
	
# Desenha um retangulo	
func draw_area(s = true):
	rect_draw.rect_size = Vector2(abs(start_v.x-end_v.x), abs(start_v.y - end_v.y))
	
	var pos = Vector2()
	pos.x = min(start_v.x, end_v.x)
	pos.y = min(start_v.y, end_v.y)

	rect_draw.rect_position = pos
	
	# Se passar o parametro como falso, apagamos o retangulo
	# deixando sua area = 0
	rect_draw.rect_size *= int(s) # true = 1 and false = 0

# Captura a posicao do mouse	
func _input(event):
		if event is InputEventMouse:
			mouse_pos = event.position
			mouse_pos_global = get_global_mouse_position()