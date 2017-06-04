
extends KinematicBody2D

const ROTATE_SPEED = 5
const SPEED = 100
const HUNT_SPEED = 200
const HUNT_PROBABILITY = 10
const HUNT_COUNTER_MAX  = 5
const HUNT_SIGHT = 150
const WANDER_PROBABILITY = 20
const WANDER_COUNTER_MAX = 1
const STOP_TIME = 1
const POINTS_AWARD = 500

var main

var ball_node
var stop_mov
var new_pos setget ,get_target
var is_hunting setget ,is_hunting
var hunt_countdown
var wander_counter 
var direction = Vector2(-1, -1)

func _ready( ):
	main = get_node( "/root/main" );
	ball_node = get_tree().get_nodes_in_group( main.BALL_NODE )
	ball_node = ball_node[0]
	set_fixed_process(true)
	is_hunting = false
	wander_counter = 0
	hunt_countdown = HUNT_COUNTER_MAX
	get_node( "Collider" ).set_trigger(true)
	
	var x = main.random(525)+25;
	var y = main.random(575)+25;
	new_pos= Vector2(x,y)
	pass


func _fixed_process(delta ):
	
	#Se ha mangiato la palla, sta fermo per un pò
	if( stop_mov ):
		var angle = get_angle_to( new_pos )
		rotate( angle * delta * ROTATE_SPEED )
		return
		
	hunt_countdown -= 1*delta
	var speed = SPEED
	
	#TODO Dopo un certo periodo di tempo, ricomincia a cacciare la palla
	if( !is_hunting and main.random( 100 ) < HUNT_PROBABILITY and hunt_countdown < 0  ):
		var dist = get_pos().distance_to( ball_node.get_global_pos() )
		if( dist < HUNT_SIGHT ):
			is_hunting = true	
	
	
	#Se sta cacciando, si muove verso la palla, altrimenti si muove casualmente
	if( is_hunting ):
		new_pos = ball_node.get_global_pos()	
		speed = HUNT_SPEED
		
	else:
		wander_counter -=1*delta
				
	#calcolo destinazione
	if( main.random( 100 ) < WANDER_PROBABILITY and wander_counter <= 0 ):
		_get_new_destination( true )
	
	#Finchè ha trovato un punto abbastanza lontano dall'obiettivo precente ricalcolo destinazione
	#(Evita che scelga posizioni troppo vicine)
	var too_close = get_global_pos().distance_to( new_pos )<5
	while( too_close ):
		_get_new_destination( true )
		too_close = get_global_pos().distance_to( new_pos )<5
	
	#Guarda la palla
	var angle = get_angle_to( new_pos )
	rotate( angle*delta*ROTATE_SPEED )
	
	#Insegue la palla
	var ball_dir = new_pos - get_global_pos()
	ball_dir=ball_dir.normalized()
	move( ball_dir*speed*delta )

#Smette di muoversi e di cacciare
func stop_hunting():
	is_hunting = false
	stop_mov = true
	_get_new_destination( false )
		
#Ricomincia a muoversi
func restart_movement():
	hunt_countdown = HUNT_COUNTER_MAX
	stop_mov = false

#Trova una nuova destinazione per il movimento normale
func _get_new_destination(must_restart_counter ):
	var x = 525*( main.random( 2 )-1 )/main.random( 2 );
	var y = 575*( main.random( 2 )-1 )/main.random( 2 );
	x = clamp( x,50,550 )
	y = clamp( y,50,550 )
	new_pos= Vector2( x, y )
	if( must_restart_counter ):
		wander_counter = WANDER_COUNTER_MAX
	
func get_target():
	return new_pos

func is_hunting():
	return is_hunting