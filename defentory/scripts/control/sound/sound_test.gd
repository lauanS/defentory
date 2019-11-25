extends AudioStreamPlayer2D

func _ready():
	play()

func play_sound():
	if not playing:
		play()