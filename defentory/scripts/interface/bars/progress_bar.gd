extends MarginContainer


var bar

func _ready():
	bar = get_node("/root/tower/progress_bar/bar/gauge")
	
func set_bar(value):
	bar.set_value(value)
	


func _on_tower_building(value):
	bar.set_value(value)
