extends Node2D

func _ready():
	$sound.set_sound("res://assets/sounds/building.wav")


func _on_started_building():
	print('start_playing')
	$sound.start_playing()


func _on_stopped_building():
	print('stop_playing')
	$sound.stop_playing()
