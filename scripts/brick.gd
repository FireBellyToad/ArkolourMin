
extends StaticBody2D

var colors = preload("res://scripts/colors.gd")
var brick_color 
var brick_hardness

func _ready():
	init_brick()

#Inizializza il Mattone
func init_brick():
	var new_color = 0;
	brick_hardness = 0;
	
	for group in get_groups():
		if(group == "Red"):
			new_color += colors.get_red_val()
			
		if(group == "Blue"):
			new_color += colors.get_blue_val()
			
		if(group == "Yellow"):
			new_color += colors.get_yellow_val()		
			
		if(group == "Normal"):
			brick_hardness = 2
			
		if(group == "Hard"):
			brick_hardness = 4
			
		if(group == "SuperHard"):
			brick_hardness = 6
	
	if(brick_hardness == 0):
		brick_hardness = colors.random(3)*2
	
	if(new_color == 0):
		new_color = colors.random(7)
	
	_set_brick_color(new_color)
	_update_brick_hardness()

#Setta il colore grafico del Mattone
func _set_brick_color(new_color):	
	brick_color = new_color
	get_node("Viewport/Brick3D/LeftSide").set_material_override(colors.get_brick_mat(brick_color,"LeftSide"))
	get_node("Viewport/Brick3D/MiddleLeft").set_material_override(colors.get_brick_mat(brick_color,"MiddleLeft"))
	get_node("Viewport/Brick3D/MiddleRight").set_material_override(colors.get_brick_mat(brick_color,"MiddleRight"))
	get_node("Viewport/Brick3D/RightSide").set_material_override(colors.get_brick_mat(brick_color,"RightSide"))

#Aggiorna la durezza del Mattone
func _update_brick_hardness():
		
	if(brick_hardness >4):
		get_node("Hardness").set_opacity(0.8)
		return
		
	if(brick_hardness >2):
		get_node("Hardness").set_opacity(0.4)
		return
	
	get_node("Hardness").set_opacity(0)
	
#Decrementa la durezza del mattone. Se ridotta a zero, il mattone è distrutto
func decrease_hardness(ball_size):
	brick_hardness -=ball_size
	_update_brick_hardness()
	if(brick_hardness <= 0):
		queue_free()
	
#Ottinee un colore da un mattone. Se ha colori misti, viene scelto casualmente	
func get_color_from_brick():
	
	if(brick_color == colors.get_blue_yellow_val()):
		if(colors.random(2) == 1):
			return colors.get_blue_val()	
		return colors.get_yellow_val()
	
	if(brick_color == colors.get_red_yellow_val()):
		if(colors.random(2) == 1):
			return colors.get_red_val()		
		return colors.get_yellow_val()
	
	if(brick_color == colors.get_red_blue_val()):
		if(colors.random(2) == 1):
			return colors.get_red_val()		
		return colors.get_blue_val()
	
	if(brick_color == colors.get_red_blue_yellow_val()):
		var rand = colors.random(3)
		if(rand == 1):
			return colors.get_red_val()
		if(rand == 2):
			return colors.get_blue_val()
		return colors.get_yellow_val()	
	
	return brick_color
	
