extends Control

func _ready():
	# Carregando musica de fundo
	var music_path = "res://assets/sounds/sound_of_loniless.wav"
	$music/sound.set_sound(music_path)
	$music/sound.play_in_background()
	
	