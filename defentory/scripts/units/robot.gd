extends KinematicBody2D

export var selected = false setget set_selected

# nodes da scene
onready var box = $selected_box
onready var name_label = $name_label

# Sinais
signal was_selected
signal was_deselected

# Altera o status de selecao da unidade
func set_selected(value):
	if selected != value:
		selected = value
		box.visible = value
		name_label.visible = value
		if selected:
			emit_signal("was_selected", self)
		else:
			emit_signal("was_deselected", self)
		
func _ready():
	connect("was_deselected", get_parent(), "select_unit")
	connect("was_deselected", get_parent(), "deselect_unit")
	
	name_label.visible = false
	name_label.text = name

func _process(delta):
	pass

# Evento para verificar se a unidade esta sendo (de)selecionada
func _on_robot_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_LEFT:
				set_selected(true)
			if event.button_index == BUTTON_RIGHT:
				set_selected(false)

