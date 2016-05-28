
extends RigidBody2D

var colors = preload("res://scripts/colors.gd")

const INITIAL_SPEED = 350
const start_pos = Vector2(300,600)
var speed
var ball_color

func _ready():
	_init_ball()
	set_fixed_process(true)
	pass
	
func _init_ball():
	speed = INITIAL_SPEED	
	set_pos(start_pos) 
	_change_color(colors.get_blue_val())
	set_linear_velocity(Vector2(0,-speed))

func _fixed_process(delta):
	
	if(get_pos().y > 700):
		_init_ball()
		return
	
	var bodies = get_colliding_bodies()
	
	for body in bodies:
		
		#Se l'oggetto con cui collide è la Sbarra
		if (body.get_name() == "Bat" ):	
			
			#Rimbalza con un angolo dato dalla posizione della palla rispetto alla sbarra			
			var direction = get_pos() - body.get_node("Ancor").get_global_pos()
			var velocity = direction.normalized()*speed
			set_linear_velocity(velocity)

#Cambia colore della palla
func _change_color(color):		

	ball_color = color
	
	#Cambia il layer di collisione (se palla e sbarra non hanno lo stesso colore, non devono collidere)
	set_layer_mask(color)
	
	#cambia il colore della palla a schermo
	get_node("Viewport/Sphere").set_material_override(colors.get_mat(color))
	
