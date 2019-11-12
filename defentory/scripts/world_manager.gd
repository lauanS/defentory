extends Node2D 

var selected_units = []
var units
# Adiciona a unit a lista de unidades selecionadas
func select_unit(unit):
	if not selected_units.has(unit):
		selected_units.append(unit)

# Retira a unit da lista de unidades selecionadas
func deselect_unit(unit):
	if selected_units.has(unit):
		selected_units.erase(unit)

func deselect_all():
	for unit in selected_units:
		deselect_unit(unit)
		
func get_units_in_area(area):
	var units_in_area = []
	for unit in units:
		if unit.position.x > area[0].x and unit.position.x < area[1].x:
			if unit.position.y > area[0].y and unit.position.y < area[1].y:
				units_in_area.append(unit)
	return units_in_area
	
func area_selected(obj):
	var start = obj.start
	var end = obj.end
	var area = []
	
	area.append(Vector2(min(start.x, end.x), min(start.y, end.y)))
	area.append(Vector2(max(start.x, end.x), max(start.y, end.y)))
	var units_in_area = get_units_in_area(area)
	# 
	if not Input.is_key_pressed(KEY_SHIFT):
		deselect_all()
	for unit in units_in_area:
		unit.selected = not unit.selected
	print("area_selected: ", area[0], " to ", area[1])
func _ready():
	units = get_tree().get_nodes_in_group("units") 