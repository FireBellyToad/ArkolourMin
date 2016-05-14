
extends Spatial

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	pass
	
func _process(delta):
	
	var bat = get_node("RigidBody").get_linear_velocity();
	
	#TODO Cambiare
	if(Input.is_key_pressed( KEY_RIGHT)
		bat.x +=

