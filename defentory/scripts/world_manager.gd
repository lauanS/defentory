extends Node2D

var selected_units = []

# Adiciona a unit a lista de unidades selecionadas
func select_unit(unit):
	if not selected_units.has(unit):
		selected_units.append(unit)

# Retira a unit da lista de unidades selecionadas
func deselect_unit(unit):
	if selected_units.has(unit):
		selected_units.erase(unit)



func _ready():
	pass # Replace with function body.

#func _process(delta):
#	pass
