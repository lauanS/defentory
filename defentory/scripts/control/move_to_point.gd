extends KinematicBody2D

export var speed = 100

var move_p = false
var to_move = Vector2()
var path = PoolVector2Array()
var initial_position = Vector2()

var walking

func _ready():
	pass

func _process(delta):
	if move_p:	
		var nav = get_node("/root/stage/nav")
		var simple_path = nav.get_simple_path(position, 
								to_move + Vector2(randi() % 100, 
								randi() % 100))		
		path = simple_path
		initial_position = position
		move_p = false
	if path.size() > 0:
		move_towards(initial_position, path[0], delta)
		walking = true
	else:
		walking = false

func move_towards(pos, point, delta):
	var v = (point - pos).normalized()
	v *= delta * speed
	move_and_collide(v)
	if position.distance_squared_to(point) < 9:
		path.remove(0)
		initial_position = position
		
func move_unit(point):
	to_move = point
	move_p = true