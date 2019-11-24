extends VBoxContainer

var stage_path

func _ready():
	stage_path = "res://scenes/stages/stage01.tscn"

# Carrega a fase
func _on_btn_start_pressed():
	get_tree().change_scene(stage_path)

# Fecha o jogo
func _on_btn_quit_pressed():
	get_tree().quit()
