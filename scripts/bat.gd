
extends KinematicBody2D

var main

#Bat speed
const BAT_SPEED = 250
const BAT_Y = 625
var bat_color 

func _ready():	
	main = get_node("/root/main");
	bat_color = main.get_red_val()
	set_fixed_process(true)
	
func _fixed_process(delta):
	_control_bat(delta)
		

#Gestione input Sbarra
func _control_bat(delta):
	
	if(Input.is_action_pressed("bat_right")):
		move(Vector2(BAT_SPEED*delta,0))

	if(Input.is_action_pressed("bat_left")):
		move(Vector2(-BAT_SPEED*delta,0))
		
	if(Input.is_action_pressed("bat_red")):
		_change_color(main.get_red_val())
		
	if(Input.is_action_pressed("bat_blue")):
		_change_color(main.get_blue_val())

	if(Input.is_action_pressed("bat_yellow")):
		_change_color(main.get_yellow_val())
		
	#Toppa per evitare che la barra venga spostata verso il basso
	var bat_pos = get_global_pos()
	if(bat_pos.y != BAT_Y):
		set_global_pos(Vector2(bat_pos.x,BAT_Y))

#Cambia il colore della sbarra
func _change_color(new_color):
	
	bat_color = new_color
	
	#Cambia la mask di collisione (se palla e sbarra non hanno lo stesso colore, non devono collidere)
	set_collision_mask(new_color)
		
	#Cambia il colore renderizzato a schermo
	get_node("Viewport/Mesh").set_material_override(main.get_mat(new_color))
	
	