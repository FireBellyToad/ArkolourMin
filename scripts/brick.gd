
extends StaticBody2D

var colors = preload("res://scripts/colors.gd")
var brick_color 
var brick_hardness

func _ready():
	_init_brick()



func _init_brick():
	_set_brick_color(colors.get_red_blue_yellow_val())
	brick_hardness = 2
	
#Setta il colore gradico del Mattone
func _set_brick_color(new_color):
	brick_color = new_color
	get_node("Viewport/Brick3D/LeftSide").set_material_override(colors.get_brick_mat(brick_color,"LeftSide"))
	get_node("Viewport/Brick3D/Middle").set_material_override(colors.get_brick_mat(brick_color,"Middle"))
	get_node("Viewport/Brick3D/RightSide").set_material_override(colors.get_brick_mat(brick_color,"RightSide"))

	
#Decrementa la durezza del mattone. Se ridotta a zero, il mattone è distrutto
func decrease_hardness(ball_size):
	brick_hardness -=ball_size
	if(brick_hardness <= 0):
		queue_free()
	
#Ottinee un colore da un mattone. Se ha colori misti, viene scelto casualmente	
func get_color_from_brick():
	
	if(brick_color == colors.get_blue_yellow_val()):
		if(_random(2) == 1):
			return colors.get_blue_val()	
		return colors.get_yellow_val()
	
	if(brick_color == colors.get_red_yellow_val()):
		if(_random(2) == 1):
			return colors.get_red_val()		
		return colors.get_yellow_val()
	
	if(brick_color == colors.get_red_blue_val()):
		if(_random(2) == 1):
			return colors.get_red_val()		
		return colors.get_blue_val()
	
	if(brick_color == colors.get_red_blue_yellow_val()):
		var rand = _random(3)
		if(rand == 1):
			return colors.get_red_val()
		if(rand == 2):
			return colors.get_blue_val()
		return colors.get_yellow_val()	
	
	return brick_color
	
func _random(number):
	randomize()
	return 1+(randi()%number)