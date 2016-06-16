
extends RigidBody2D


func _ready():
	set_fixed_process(true)
	get_node("Collider").set_trigger(true)
	pass


func _fixed_process(delta):
	
	var bodies = get_colliding_bodies()
	
	#Se collide con la Sbarra, si perde una vita
	for body in bodies:
		if(body.get_name() == "Bat"):
			body.queue_free()
			queue_free()
	
	#Se esce dallo schermo viene rimosso
	if(get_pos().y >750):
		queue_free()