
extends KinematicBody2D

var colors = preload("res://scripts/colors.gd")
var ball = preload("res://scenes/ball.scn")

#Bat speed
const BAT_SPEED = 250
var bat_color 

func _ready():	
	bat_color = colors.get_red_val()
	set_process(true)
	
func _process(delta):
	_control_bat(delta)
		

#Gestione input Sbarra
func _control_bat(delta):
	
	if(Input.is_action_pressed("bat_right")):
		move(Vector2(BAT_SPEED*delta,0))

	if(Input.is_action_pressed("bat_left")):
		move(Vector2(-BAT_SPEED*delta,0))
		
	if(Input.is_action_pressed("bat_red")):
		_change_color(colors.get_red_val())
		
	if(Input.is_action_pressed("bat_blue")):
		_change_color(colors.get_blue_val())

	if(Input.is_action_pressed("bat_yellow")):
		_change_color(colors.get_yellow_val())

#Cambia il colore della sbarra
func _change_color(new_color):
	
	bat_color = new_color
	
	#Cambia la mask di collisione (se palla e sbarra non hanno lo stesso colore, non devono collidere)
	set_collision_mask(new_color)
		
	#Cambia il colore renderizzato a schermo
	get_node("Viewport/Mesh").set_material_override(colors.get_mat(new_color))
	
	