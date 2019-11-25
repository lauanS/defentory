extends Node2D 

var selected_units = []
var units

var construction

# Obtem todas as unidades da cena	
func _ready():
	units = get_tree().get_nodes_in_group("units") 
	construction = preload("res://scenes/models/towers/double_cannon_tower.tscn")
	# Carregando musica de fundo
	$music/sound.set_sound("res://assets/sounds/sound_of_madnes.wav")
	$music/sound.play_in_background()
	
# Adiciona a unit a lista de unidades selecionadas
func select_unit(unit):
	if not selected_units.has(unit):
		selected_units.append(unit)

# Retira a unit da lista de unidades selecionadas
func deselect_unit(unit):
	if selected_units.has(unit):
		selected_units.erase(unit)

# Retira todas as unidades da lista de unidade selecionadas
func deselect_all():
	var i = len(selected_units) - 1
	var unit
	while i >= 0:
		unit = selected_units[i]
		unit.selected = false
		i -= 1;


# Obtem as unidades na area
func get_units_in_area(area):
	var units_in_area = []
	for unit in units:
		if unit.position.x > area[0].x and unit.position.x < area[1].x:
			if unit.position.y > area[0].y and unit.position.y < area[1].y:
				units_in_area.append(unit)
	return units_in_area

# Gera a area selecionada e obtem as unidades nela
func area_selected(obj):
	var start = obj.start
	var end = obj.end
	var area = []
	
	area.append(Vector2(min(start.x, end.x), min(start.y, end.y)))
	area.append(Vector2(max(start.x, end.x), max(start.y, end.y)))
	var units_in_area = get_units_in_area(area)
	 
	for unit in units_in_area:
		unit.selected = not unit.selected

# Move as unidades selecionadas	
func start_move_selection(obj):
	for unit in selected_units:
		unit.move_unit(obj.move_to_point)


func set_construction(path):
	construction = load(path)

func instance_construction():
	var new_construction = construction.instance()
	new_construction.set_position(get_global_mouse_position())
	add_child(new_construction)
	
func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("ui_build"):
			instance_construction()
		if Input.is_key_pressed(KEY_SHIFT):
			deselect_all()
