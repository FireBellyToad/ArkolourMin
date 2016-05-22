
extends RigidBody2D

const INITIAL_SPEED = 350
var speed

func _ready():
	
	_init_ball()
	set_fixed_process(true)
	pass
	
func _init_ball():
	speed = INITIAL_SPEED	
	set_linear_velocity(Vector2(0,-speed))

func _fixed_process(delta):
	
	var bodies = get_colliding_bodies()
	
	for body in bodies:
		
		#Se l'oggetto con cui collide è la Sbarra
		if (body.get_name() == "Bat"):
			#Rimbalza in un angolo che 
			var direction = get_pos() - body.get_node("Ancor").get_global_pos()
			var velocity = direction.normalized()*speed
			set_linear_velocity(velocity)
