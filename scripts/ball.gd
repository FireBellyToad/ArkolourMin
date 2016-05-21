
extends RigidBody

const INITIAL_SPEED = 10
var speed

func _ready():
	
	
	_init_ball()
	pass
	
func _init_ball():
	#TODO cambiare
	speed = INITIAL_SPEED	
	set_linear_velocity(Vector3(0,-speed,0))

