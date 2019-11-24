extends StaticBody2D

var sprite
var new_color 

var transparency = 0

var completed = false

var nearby_units = []
var timer
var bar
var progress = 0

func _ready():
	# Deixa transparente a construcao ao ser instanciada
	sprite = get_node("sprite")
	sprite.set_modulate(Color(1, 1, 1, 0.5))
	
	# Define o tempo de construcao 
	timer = get_node("build_area/timer")
	
	timer.set_wait_time( 10 )
	timer.connect("timeout", self, "_on_Timer_timeout")
	
	bar = get_node("progress_bar/bar/gauge")
	bar.set_modulate(Color(1, 1, 1, 0.5))
	bar.set_value(progress)
	
func _process(delta):
	if nearby_units:
		construction()
			
func construction():
	progress = (1 - timer.get_time_left()/10)* 100
	bar.set_value(progress)	

# Evento ativado quando algo se aproxima do obj
func _on_build_area_body_entered(body):
	# Verifica se o corpo que se aproximou eh uma unidade
	if body in get_tree().get_nodes_in_group("units"):
		nearby_units.append(body)
		# Inicia o timer pela primeira vez
		if timer.is_stopped() and not completed:
			timer.start()
		# Continua o timer caso ele esteja parado
		if timer.is_paused():
			timer.set_paused(false)

# Evento ativado quando algo se distancia do obj
func _on_build_area_body_exited(body):
	# Verifica se o corpo que se aproximou eh uma unidade
	if body in get_tree().get_nodes_in_group("units"):
		nearby_units.erase(body)
		# Se nao tiver mais nenhuma unidade proximo
		if not nearby_units:
			# Pausa a construcao
			timer.set_paused(true)
			
	
func _on_Timer_timeout():
	bar.visible = false
	sprite.set_modulate(Color(1, 1, 1, 1))
	completed = true
	