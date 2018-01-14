
extends RigidBody2D

#Inizializzarli sempre
var main 

#Costanti
const INITIAL_SPEED = 350
const NORMAL_SIZE = 2
const LITTLE_SIZE = 1
const BIG_SIZE = 100
const STOP_TIME = 1
const BALL_START_POS= Vector2(300,600)
const INITIAL_MULTIPLIER= 1
const MAX_MULTIPLIER = 5
const FIXED_EMITTING = 0.025 
const EMITTING_FACTOR = 0.1 

#Variabili
var ball_speed
var ball_color
var ball_size
var move_time
var ball_powered 
var ball_multiplier
var last_triang_body

func _ready( ):
	main = get_node( "/root/main" );
	_init_ball()
	set_fixed_process( true )
	
func _init_ball( ):
	ball_powered = false;	
	#get_node( "Emitter" ).set_emitting( true )
	#get_node("Emitter").set_lifetime( FIXED_EMITTING )
	get_node("Trail").set_track_length( 0 )
	ball_speed = INITIAL_SPEED
	restore_size()
	move_time = 0
	ball_multiplier = INITIAL_MULTIPLIER
	set_pos( BALL_START_POS ) 
	_change_color( main.get_red_val() )
	set_linear_velocity( Vector2( 0, -ball_speed ) )

func _fixed_process(delta ):	
	
	#Decrementa il timer, dopo un certo periodo di tempo che è stata mangiata ricomincia a muoversi
	if( move_time > 0 ):
		move_time -=1*delta
		return 
		
	if( move_time < 0 ):
		move_time = 0
		ball_speed = INITIAL_SPEED
		last_triang_body.restart_movement()
		var target = last_triang_body.get_target()
		var direction = target - get_pos()
		var velocity = direction.normalized()
		set_linear_velocity( velocity*ball_speed )
	 
	var velocity = get_linear_velocity()
	
	#Se esce fuori dallo schermo, perde una vita
	if( get_pos().y > 700 ):
		get_parent().get_node( main.BAT_NODE ).die()
	
	var bodies = get_colliding_bodies()
	
	for body in bodies:
		
		#Se l'oggetto con cui collide è un Mattone
		if ( body.is_in_group("Brick") ):
			#Decrementa la durezza del mattone e ne prende un colore
			body.decrease_hardness( ball_size, ball_powered, ball_multiplier )
			_change_color( body.get_color_from_brick() )
		
		#Se l'oggetto con cui collide è la Sbarra
		if ( body.get_name() == main.BAT_NODE ):	
				
			#Se ha il bonus multicolor, è automaticamente potenziata	
			if( body._get_current_empowerment() == main.BONUS_M ): 
				ball_powered = true
			else:
				ball_powered = body._get_color() == ball_color;
			
			#Se si continua a tenere il colore corretto, il moltiplicatore di punti aumenta
			if( ball_powered ):
				ball_multiplier = min( ball_multiplier+1, MAX_MULTIPLIER )
			else:
				ball_multiplier = INITIAL_MULTIPLIER
			
			#Disegna la scia di una lunghezza fissa a seconda del moltiplicatore	
			#get_node("Emitter").set_lifetime( FIXED_EMITTING + ( EMITTING_FACTOR * ( ball_multiplier- 1) ) )
			get_node("Trail").set_track_length( ( ball_multiplier - 1) * 10 )
					
			#Rimbalza con un angolo dato dalla posizione della palla rispetto alla sbarra
			var direction = get_pos() - body.get_node( "Ancor" ).get_global_pos()
			var velocity = direction.normalized() * ball_speed
			set_linear_velocity( velocity )
			
		#Se l'oggetto con cui collide è un nemico, lo elimina dal gioco
		if( body.is_in_group( "Enemy") ):
			
			#Se l'oggetto con cui collide è un nemico Triangolo ed è di taglia normale
			if( body.is_in_group( "Triangle" ) and ball_size != BIG_SIZE  ):
				
				#Se non è a caccia, gli passa attraverso
				if( !body.is_hunting() ):
					return
				
				#Se è a caccia, viene bloccato nello "stomaco"
				move_time = STOP_TIME
				set_linear_velocity( Vector2( 0, 0 ) )
				set_global_pos( body.get_node( "Stomach" ).get_global_pos() )
				body.stop_hunting()
				last_triang_body = body
				return
				
			var direction = get_pos() - body.get_global_pos()
			var velocity = direction.normalized() * ball_speed
			set_linear_velocity( velocity )
			body.queue_free()
			#Se la palla è potenziata, raddopiano i punti
			if( ball_powered ):
				main.score += body.POINTS_AWARD * ball_multiplier
			else:
				main.score += body.POINTS_AWARD

#Cambia colore della palla
func _change_color( new_color ):		

	ball_color = new_color
	
	#Cambia il layer di collisione se difficoltà CLASSICA  
	#(se palla e sbarra non hanno lo stesso colore, non devono collidere)
	if(not main.is_normal_difficulty() ):
		set_layer_mask( new_color )
	
	#cambia il colore della palla a schermo
	get_node( "Viewport/Sphere" ).set_material_override( main.get_mat( new_color ) )
	
	#get_node( "Emitter" ).set_color( main.get_godot_color( new_color ) )
	get_node("Trail").set_trail_color(main.get_godot_color( new_color) )
	
func _on_Death_timeout( ):	
	_init_ball()
	pass # replace with function body

#Rende la palla distruttiva ( big ) - Bonus B
func enlarge():
	ball_size = BIG_SIZE
	get_node( "Viewport/Sphere" ).set_hidden( true )
	
#Resetta lo stato della palla ( da big o hollow )
func restore_size():
	ball_size = NORMAL_SIZE
	get_node( "Viewport/HollowSphere" ).set_hidden( true )
	get_node( "Viewport/Sphere" ).set_hidden( false )

#Rende la palla vuota ( hollow ) - Malus H
func hollow():
	ball_size = LITTLE_SIZE
	get_node( "Viewport/Sphere" ).set_hidden( true )
	get_node( "Viewport/HollowSphere" ).set_hidden( false )

#Cambia la velocità della palla 
func set_accelleration( delta ):
	ball_speed += delta	
	var direction = get_pos()
	var velocity = direction.normalized() * ball_speed
	set_linear_velocity( velocity )

#Resetta la velocità della palla
func reset_accelleration():
	ball_speed = INITIAL_SPEED
	var direction = get_pos() 
	var velocity = direction.normalized() * ball_speed
	set_linear_velocity( velocity )
	
func get_ball_multiplier():
	return ball_multiplier