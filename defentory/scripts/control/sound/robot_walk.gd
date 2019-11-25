extends Node2D

func _ready():
	$sound.set_sound("res://assets/sounds/robot_walk.wav")

func _on_robot_started_walking():
	$sound.start_playing()

func _on_robot_stopped_walking():
	$sound.stop_playing()
