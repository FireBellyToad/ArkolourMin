
extends Spatial

#Bat speed
var speed = 10

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	pass
	
func _process(delta):
	
	_move_bat(delta)

func _move_bat(delta):
	var movement = get_translation()
	
	if(Input.is_action_pressed("bat_right")):
		movement += (Vector3(speed,0,0)*delta)

	if(Input.is_action_pressed("bat_left")):
		movement += (Vector3(-speed,0,0)*delta)

	set_translation(movement)