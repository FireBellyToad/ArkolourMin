
extends KinematicBody2D

var main

#Bat speed
const BAT_SPEED = 250
const BAT_Y = 625
const BAT_START_POS = Vector2( 300 , 625 )
const STANDARD_BONUS_DURATION = 30

var bat_color setget ,_get_color
var multicolor_animation
var current_empowerment setget ,_get_current_empowerment

var new_ball = preload("res://scenes/ball.scn")

func _ready():	
	main = get_node( "/root/main" );
	multicolor_animation = get_node( "MulticolorAnimation" );
	_init_bat()
	set_fixed_process( true )
	
func _init_bat():	
	_change_color( main.get_red_val() )
	set_global_pos( BAT_START_POS )
	set_hidden( false ) 
	_on_PowerupsTimeout_timeout()
	
func _fixed_process( delta ):
	_control_bat( delta )

#Gestione input Sbarra
func _control_bat( delta ):
	
	if( Input.is_action_pressed( "bat_right" ) ):
		move( Vector2( BAT_SPEED*delta, 0 ))

	if( Input.is_action_pressed( "bat_left" ) ):
		move( Vector2( -BAT_SPEED*delta, 0 ) )
		
	if( Input.is_action_pressed( "bat_red" ) and not( current_empowerment == main.BONUS_M ) ):
		_change_color( main.get_red_val() )
		
	if( Input.is_action_pressed( "bat_blue" ) and not( current_empowerment == main.BONUS_M ) ):
		_change_color( main.get_blue_val() )

	if( Input.is_action_pressed( "bat_yellow" ) and not( current_empowerment == main.BONUS_M ) ):
		_change_color( main.get_yellow_val() )
		
	#Toppa per evitare che la barra venga spostata verso il basso
	var bat_pos = get_global_pos()
	if( bat_pos.y != BAT_Y ):
		set_global_pos( Vector2( bat_pos.x, BAT_Y ) )

#Cambia il colore della sbarra
func _change_color( new_color ):
	
	bat_color = new_color
	
	#Cambia la mask di collisione se difficoltà CLASSICA (se palla e sbarra non hanno lo stesso colore, non devono collidere)	
	if(not main.is_normal_difficulty()):
		set_collision_mask( new_color )
		
	#Cambia il colore renderizzato a schermo
	get_node("Viewport/Mesh").set_material_override( main.get_mat( new_color ) )
	
func _get_color():
	return bat_color;	
	
func restart():
	_init_bat()

#Chiama il timer per gestire la callback della morte
func die():
	var timer = get_parent().get_node( "Death" )
	if(!timer.is_processing()):
		timer.set_wait_time(1)
		timer.set_one_shot(true)
		timer.start()
		yield( timer, "timeout" )

#Callback del timer di morte
func _on_Death_timeout():
	#Se ha ancora vite disponibili, ricomincia la partita, altrimenti esce dal gioco
	if( main.bat_lives > 1 ):
		main.bat_lives -=1
		_init_bat()
	else:
		game_over()
	pass

func _get_current_empowerment():
	return current_empowerment

#Conferisce un power up
func empower(power_value):
	
	_on_PowerupsTimeout_timeout()
	
	if( current_empowerment == power_value ):
		return;
	
	if( power_value == main.BONUS_1UP ):
		main.bat_lives +=1
		return
		
	if( power_value == main.BONUS_5000 ):
		main.add_score( 5000 )
		return
	
	if( power_value == main.BONUS_L ):
		scale( Vector2( 2,1 ) )
	
	if( power_value == main.BONUS_M ):
		multicolor_animation.set_active( true )
		
	if( power_value == main.BONUS_D ):
		get_parent().get_node( main.BALL_NODE ).enlarge()
	
	if( power_value == main.BONUS_S ):
		get_parent().get_node( main.BALL_NODE ).set_accelleration( -125 )
			
	if( power_value == main.MALUS_H ):
		get_parent().get_node( main.BALL_NODE ).hollow()
		
	if( power_value == main.MALUS_F ):
		get_parent().get_node( main.BALL_NODE ).set_accelleration( 350 )		
	
	if( power_value == main.MALUS_C ):
		set_cmalus_timeout()
		
	set_powerup_timeout()
	current_empowerment = power_value

func set_powerup_timeout():
	
	var timer = get_node( "PowerupsTimeout" )
								
	if( timer.is_processing() ):
		timer.stop()
		
	timer.set_wait_time( STANDARD_BONUS_DURATION )
	timer.set_one_shot( true )
	timer.start()
	yield( timer, "timeout" )

func _on_PowerupsTimeout_timeout():	
	
		if( current_empowerment == null ):
			return;	
		
		if( current_empowerment == main.BONUS_M ):
			multicolor_animation.set_active(false)
			_change_color( bat_color )
		
		if( current_empowerment == main.BONUS_L ):
			scale( Vector2( 0.5,1 ) )
			
		if( current_empowerment == main.BONUS_D or current_empowerment == main.MALUS_H ):
			get_parent().get_node( main.BALL_NODE ).restore_size()
		
		if( current_empowerment == main.BONUS_S or current_empowerment == main.MALUS_F ):
			get_parent().get_node( main.BALL_NODE ).reset_accelleration()
			
		if( current_empowerment == main.MALUS_C ):
			stop_cmalus_timeout()
			
		current_empowerment = null

#Game Over callback
func game_over():
	#TODO cambiare
	get_tree().change_scene( "res://scenes/title.tscn" )

#Timeout cambio colore
func set_cmalus_timeout():
	
	var timer = get_node( "CMalusTimeout" )
	
	if( timer.is_processing() ):
		timer.stop()
		
	timer.set_wait_time( 1.5 )
	timer.set_one_shot( false )
	timer.start()
	yield( timer, "timeout" )
	

func stop_cmalus_timeout():
	var timer = get_node( "CMalusTimeout" )
	timer.stop()
	
func _on_CMalusTimeout_timeout():
	
	var color_placeholder = null
	var rand = main.random( 3 )
		
	#Assegno alla barra un colore casuale diverso da quello attuale
	while( color_placeholder == null || color_placeholder ==  bat_color ):
		if( rand == 1 ):
			color_placeholder =  main.get_red_val()
		else:
			if( rand == 2 ):
				color_placeholder =  main.get_blue_val()
			else:
				color_placeholder =  main.get_yellow_val()
		rand = main.random( 3 )
	
	_change_color( color_placeholder )
	pass
