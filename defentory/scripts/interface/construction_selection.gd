extends HBoxContainer

var path_double_cannon = 'res://scenes/models/towers/double_cannon_tower.tscn'
var path_basic_wall = 'res://scenes/models/walls/basic_wall.tscn'

var stage
func _ready():
	stage = get_node('/root/stage')


func _on_double_cannon_tower_pressed():
	stage.set_construction(path_double_cannon)


func _on_basic_wall_pressed():
	stage.set_construction(path_basic_wall)
