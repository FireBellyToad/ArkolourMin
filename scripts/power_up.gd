extends Area2D

const DOWN = Vector2(0,1)
const SPEED = 125

var main
var power_value
var letter_label
var power_letter

func _ready():
	letter_label = get_node( "Label" )
	set_fixed_process( true )
	get_node( "Collider" ).set_trigger( true )
	pass
	
func _set_main(main_passed):
	main = main_passed
	
func _fixed_process( delta ):
	
	translate( DOWN*SPEED*delta )
		
	#Se esce dallo schermo viene rimosso
	if( get_pos().y >750 ):
		queue_free()
	
func _set_power_up_letter( power_value_passed ):
	
	power_value = power_value_passed
	
	#Bonus
	
	if( power_value == main.BONUS_M ):
		power_letter = "M"
		
	if( power_value == main.BONUS_L ):
		power_letter = "L"
		
	if( power_value == main.BONUS_D ):
		power_letter = "D"
		
	if( power_value == main.BONUS_S ):
		power_letter = "S"
		
	if( power_value == main.BONUS_1UP ):
		power_letter = "+"
		
	if( power_value == main.BONUS_5000 ):
		power_letter = "5"
		
	if( power_value == main.BONUS_G ):
		power_letter = "G"
		
	#Malus
	
	if( power_value == main.MALUS_C ):
		power_letter = "C"
		
	if( power_value == main.MALUS_F ):
		power_letter = "F"
		
	if( power_value == main.MALUS_H ):
		power_letter = "H"
		
	if( power_value == main.MALUS_I ):
		power_letter = "I"
		
	letter_label.set_text( power_letter )
	
	if( _is_malus() ):
		letter_label.add_color_override( "font_color", main.WHITE_COLOR )
		
	get_node( "Viewport/PowerUpBody/Plane" ).set_material_override( main.get_power_up_mat( _is_malus() ) )

		
func _is_malus():
	return power_value in [main.MALUS_C, main.MALUS_I, main.MALUS_H, main.MALUS_F]


func _on_PowerUp_body_enter( body ):
	if(body.has_method("empower")):
		body.empower(power_value)
		queue_free()
