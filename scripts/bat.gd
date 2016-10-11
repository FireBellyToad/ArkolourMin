
extends KinematicBody2D

var main

#Bat speed
const BAT_SPEED = 250
const BAT_Y = 625
const BAT_START_POS = Vector2(300,625)

var bat_color setget ,_get_color

func _ready():	
	main = get_node("/root/main");
	_init_bat()
	set_fixed_process(true)
	
func _init_bat():	
	bat_color = main.get_red_val()
	set_global_pos(BAT_START_POS);
	#TODO invisibilizzare meglio sbarra
	set_opacity(1)
	
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
	
	#Cambia la mask di collisione se difficoltà CLASSICA (se palla e sbarra non hanno lo stesso colore, non devono collidere)	
	if(not main.is_normal_difficulty()):
		set_collision_mask(new_color)
		
	#Cambia il colore renderizzato a schermo
	get_node("Viewport/Mesh").set_material_override(main.get_mat(new_color))
	
	
func _get_color():
	return bat_color;	
	
func restart():
	_init_bat()

#Chiama il timer per gestire la callback della morte
func die():
	var timer = get_parent().get_node("Death")
	if(!timer.is_processing()):
		timer.set_wait_time(1)
		timer.set_one_shot(true)
		timer.start()
		yield(timer,"timeout")

#Callback del timer di morte
func _on_Death_timeout():
	#Se ha ancora vite disponibili, ricomincia la partita, altrimenti esce dal gioco
	if(main.bat_lives > 1):
		main.bat_lives -=1
		_init_bat()
	else:
		get_tree().change_scene("res://title.tscn")
	pass
