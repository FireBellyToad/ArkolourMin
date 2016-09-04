
extends RigidBody2D

var colors = preload("res://scripts/colors.gd")

#Costanti
const INITIAL_SPEED = 350
const NORMAL_SIZE = 2
const LITTLE_SIZE = 1
const BIG_SIZE = 100
const STOP_TIME = 1
const start_pos = Vector2(300,600)

#Variabili
var ball_speed
var ball_color
var ball_size
var move_time
var last_triang_body

func _ready():
	_init_ball()
	set_fixed_process(true)
	
func _init_ball():
	ball_speed = INITIAL_SPEED
	ball_size = NORMAL_SIZE
	move_time = 0
	set_pos(start_pos) 
	_change_color(colors.get_red_val())
	set_linear_velocity(Vector2(0,-ball_speed))

func _fixed_process(delta):
	
	#Decrementa il timer, dopo un certo periodo di tempo che è stata mangiata ricomincia a muoversi
	if(move_time > 0):
		move_time -=1*delta
		return 
		
	if(move_time < 0):
		move_time = 0
		ball_speed = INITIAL_SPEED
		last_triang_body.restart_movement()
		var target = last_triang_body.get_target()
		var direction = target - get_pos()
		var velocity = direction.normalized()
		set_linear_velocity(velocity*ball_speed)
	 
	var velocity = get_linear_velocity()
	
	#TODO se esce fuori dallo schermo, perde una vita
	if(get_pos().y > 700):
		_init_ball()
		return
	
	var bodies = get_colliding_bodies()
	
	for body in bodies:
		
		#Se l'oggetto con cui collide è un Mattone
		if (body.is_in_group("Brick")):
			#Decrementa la durezza del mattone e ne prende un colore
			body.decrease_hardness(ball_size)
			_change_color(body.get_color_from_brick())
		
		#Se l'oggetto con cui collide è la Sbarra
		if (body.get_name() == "Bat" ):	
			
			#Rimbalza con un angolo dato dalla posizione della palla rispetto alla sbarra			
			var direction = get_pos() - body.get_node("Ancor").get_global_pos()
			var velocity = direction.normalized()*ball_speed
			set_linear_velocity(velocity)
			
		#Se l'oggetto con cui collide è un nemico, lo elimina dal gioco
		if(body.is_in_group("Enemy")):
			
			#Se l'oggetto con cui collide è un nemico Triangolo ed è di taglia normale
			if(body.is_in_group("Triangle") and ball_size != BIG_SIZE ):
				
				#Se non è a caccia, gli passa attraverso
				if(!body.is_hunting()):
					return
				
				#Se è a caccia, viene bloccato
				move_time = STOP_TIME
				set_linear_velocity(Vector2(0,0))
				set_global_pos(body.get_node("Stomach").get_global_pos())
				body.stop_hunting()
				last_triang_body = body
				return
				
			var direction = get_pos() - body.get_global_pos()
			var velocity = direction.normalized()*ball_speed
			set_linear_velocity(velocity)
			body.queue_free()

#Cambia colore della palla
func _change_color(new_color):		

	ball_color = new_color
	
	#Cambia il layer di collisione (se palla e sbarra non hanno lo stesso colore, non devono collidere)
	set_layer_mask(new_color)
	
	#cambia il colore della palla a schermo
	get_node("Viewport/Sphere").set_material_override(colors.get_mat(new_color))
	
