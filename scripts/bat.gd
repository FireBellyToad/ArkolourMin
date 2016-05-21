
extends KinematicBody

#Bat speed
const BAT_SPEED = 10

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)
	pass
	
func _fixed_process(delta):
	
	_move_bat(delta)

func _move_bat(delta):
	
	if(Input.is_action_pressed("bat_right")):
		move(Vector3(BAT_SPEED*delta,0,0))

	if(Input.is_action_pressed("bat_left")):
		move(Vector3(-BAT_SPEED*delta,0,0))