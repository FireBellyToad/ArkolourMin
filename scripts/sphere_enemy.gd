
extends RigidBody2D

var drops = preload("res://scenes/black_drop.scn")

const SPEED = 100
const DROP_FREQUENCY = 2;
const DROP_PROBABILITY = 25;
const POINTS_AWARD = 500

var drop_countdown

func _ready():
	main = get_node( "/root/main" );
	reload()
	set_linear_velocity( Vector2( -SPEED, -SPEED) )
	get_node( "Collider" ).set_trigger( true )
	set_fixed_process( true )
	pass

func _fixed_process( delta ):
	
	#Se il countdown è scaduto, c'è una certa probabilità che sia pronto a 
	#creare una goccia
	drop_countdown -= 1*delta
	
	if(main.random( 100 ) < DROP_PROBABILITY and drop_countdown < 0 ):
		_spawn_drop()
	
	#se raggiunge una certa zona dello schermo, rimbalza verso l'alto
	var velocity = get_linear_velocity()
	if( get_global_pos().y > 400 ):
		set_linear_velocity( Vector2( velocity.x,-SPEED ))
		return
		
	if( get_global_pos().y < 25 ):
		set_linear_velocity( Vector2( velocity.x,SPEED ))
		return
	
	if( get_global_pos().x > 575 ):
		set_linear_velocity( Vector2( -SPEED, velocity.x ))
		return	

	if(get_global_pos().x < 25):
		set_linear_velocity(Vector2(SPEED,velocity.x))
		return	
	
	
#Crea una nuova goccia
func _spawn_drop():
	var new_drop = drops.instance()
	new_drop.set_pos(get_global_pos())
	get_parent().add_child( new_drop )
	reload()

func reload():
	drop_countdown = DROP_FREQUENCY;
