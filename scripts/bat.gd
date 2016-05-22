
extends KinematicBody2D

#Bat speed
const BAT_SPEED = 250

func _ready():
	set_process(true)
	pass
	
func _process(delta):	
	_move_bat(delta)

#Gestione movimento Sbarra
func _move_bat(delta):
	
	if(Input.is_action_pressed("bat_right")):
		move(Vector2(BAT_SPEED*delta,0))

	if(Input.is_action_pressed("bat_left")):
		move(Vector2(-BAT_SPEED*delta,0))