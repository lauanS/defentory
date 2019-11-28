extends AudioStreamPlayer2D

var path_sound
var keep_playing = false

func _ready():
	pass

func _process(_delta):
	if keep_playing:
		play_song()
		
func play_in_background():
	keep_playing = true
	
func start_playing():
	keep_playing = true
	play()
	
func stop_playing():
	keep_playing = false
	stop()
	
func play_song():
	if not playing:
		play()
		
func set_sound(path):
	path_sound = path
	set_stream(load(path))