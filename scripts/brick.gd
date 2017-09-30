
extends StaticBody2D

const POINTS_AWARD = 200

var main

var brick_color 
var brick_hardness
var powers = preload( "res://scenes/power_up.tscn" )
var drops = preload( "res://scenes/black_drop.scn" )

func _ready():
	main = get_node( "/root/main" );
	init_brick()

#Inizializza il Mattone
func init_brick():
	var new_color = 0;
	brick_hardness = 0;
	
	for group in get_groups():
		if( group == "Red" ):
			new_color += main.get_red_val()
			
		if( group == "Blue" ):
			new_color += main.get_blue_val()
			
		if( group == "Yellow" ):
			new_color += main.get_yellow_val()		
			
		if( group == "Normal" ):
			brick_hardness = 2
			
		if( group == "Hard" ):
			brick_hardness = 4
			
		if( group == "SuperHard" ):
			brick_hardness = 6
	
	if( brick_hardness == 0 ):
		brick_hardness = main.random( 3 )*2
	
	if( new_color == 0 ):
		new_color = main.random( 7 )
	
	_set_brick_color( new_color )
	_update_brick_hardness()

#Setta il colore grafico del Mattone
func _set_brick_color(new_color):	
	brick_color = new_color
	get_node( "Viewport/Brick3D/LeftSide" ).set_material_override( main.get_brick_mat( brick_color, "LeftSide" ) )
	get_node( "Viewport/Brick3D/MiddleLeft" ).set_material_override( main.get_brick_mat( brick_color, "MiddleLeft" ) )
	get_node( "Viewport/Brick3D/MiddleRight" ).set_material_override( main.get_brick_mat( brick_color, "MiddleRight" ) )
	get_node( "Viewport/Brick3D/RightSide" ).set_material_override( main.get_brick_mat( brick_color, "RightSide" ))

#Aggiorna la durezza del Mattone
func _update_brick_hardness():
		
	#Cambia l'opacità del mattone. Meno è opaco, più sarà scuro.
	if( brick_hardness >4 ):
		get_node( "ViewportSprite" ).set_self_opacity( 0.3 )
		return
		
	if( brick_hardness >2 ):
		get_node( "ViewportSprite" ).set_self_opacity( 0.65 )
		return
	
	get_node( "ViewportSprite" ).set_self_opacity( 1 )
	
#Decrementa la durezza del mattone. Se ridotta a zero, il mattone è distrutto
func decrease_hardness( ball_size, is_powered, ball_multiplier ):
	brick_hardness -= ball_size
	_update_brick_hardness()
	if( brick_hardness <= 0 ):
		queue_free()
		_spawn_power_up()
		if( is_powered ):
			main.score += POINTS_AWARD * ball_multiplier
		else:
			main.score += POINTS_AWARD
	
#Ottinee un colore da un mattone. Se ha colori misti, viene scelto casualmente	
func get_color_from_brick():
	
	if( brick_color == main.get_blue_yellow_val() ):
		if( main.random(2) == 1 ):
			return main.get_blue_val()	
		return main.get_yellow_val()
	
	if( brick_color == main.get_red_yellow_val() ):
		if(main.random( 2 ) == 1 ):
			return main.get_red_val()		
		return main.get_yellow_val()
	
	if(brick_color == main.get_red_blue_val()):
		if(main.random( 2 ) == 1):
			return main.get_red_val()		
		return main.get_blue_val()
	
	if( brick_color == main.get_red_blue_yellow_val() ):
		var rand = main.random( 3 )
		if( rand == 1 ):
			return main.get_red_val()
		if( rand == 2 ):
			return main.get_blue_val()
		return main.get_yellow_val()	
	
	return brick_color
	
#Genera un power up
func _spawn_power_up():
	
	var power_spawned = main.random( main.POWERUPS_NUMBER )-1
	#var power_spawned = main.MALUS_C
	
	#Malus Goccia o Altro Bonus/Malus
	if( power_spawned == main.MALUS_E ):
		var new_drop = drops.instance()
		new_drop.set_pos( get_global_pos() )
		get_parent().add_child( new_drop )
	else:
		var new_power = powers.instance()
		new_power._ready()
		new_power._set_main( main )
		new_power._set_power_up_letter( power_spawned )
		new_power.set_pos( get_global_pos() )
		get_parent().add_child( new_power )