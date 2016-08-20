
extends KinematicBody2D

var colors = preload("res://scripts/colors.gd")

const ROTATE_SPEED = 5
const SPEED = 100
const HUNT_PROBABILITY = 10
const HUNT_FREQUENCY = 5;
const WANDER_PROBABILITY = 20
const WANDER_COUNTER_MAX = 2
const STOP_TIME = 1

var ball_node
var stop_mov
var new_pos
var is_hunting setget ,is_hunting
var hunt_countdown
var wander_counter 
var direction = Vector2(-1, -1)

func _ready():
	ball_node = get_tree().get_nodes_in_group("Ball")
	ball_node = ball_node[0]
	set_fixed_process(true)
	is_hunting = false
	wander_counter = 0
	hunt_countdown = HUNT_FREQUENCY
	get_node("Collider").set_trigger(true)
	
	var x = colors.random(525)+25;
	var y = colors.random(575)+25;
	new_pos= Vector2(x,y)
	pass


func _fixed_process(delta):
	
	#Se ha mangiato la palla, sta fermo per un pò
	if(stop_mov):
		return
		
	hunt_countdown -=1*delta
	
	#TODO Dopo un certo periodo di tempo, ricomincia a cacciare la palla
	if(!is_hunting and colors.random(100) < HUNT_PROBABILITY and hunt_countdown < 0 ):
		is_hunting = true	
	
	
	#Se sta cacciando, si muove verso la palla, altrimenti si muove casualmente
	if(is_hunting):
		new_pos = ball_node.get_global_pos()	
		
	else:
				
		if(colors.random(100) < WANDER_PROBABILITY and wander_counter <= 0 ):
			if(colors.random(100) < 10):			
				var x = 525*(colors.random(2)-1)/colors.random(3)-1;
				var y = 575*(colors.random(2)-1)/colors.random(3)-1;
				new_pos= Vector2(x,y)
			
	
	#Guarda la palla
	var angle = get_angle_to(new_pos)
	rotate(angle*delta*ROTATE_SPEED)
	
	#Insegue la palla
	var ball_dir = new_pos - get_global_pos()
	ball_dir=ball_dir.normalized()
	move(ball_dir*SPEED*delta)

#Smette di muoversi e di cacciare
func stop_hunting():	
	is_hunting = false
	stop_mov = true
		
#Ricomincia a muoversi
func restart_movement():
	hunt_countdown = HUNT_FREQUENCY
	stop_mov = false
	
func is_hunting():
	return is_hunting