
extends RigidBody2D

var colors = preload("res://scripts/colors.gd")

const SPEED = 100
const DROP_FREQUENCY = 2;
const DROP_PROBABILITY = 25;

var drop_countdown
var ready setget ,is_ready

func _ready():
	reload()
	set_linear_velocity(Vector2(-SPEED,-SPEED))
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	drop_countdown -=1*delta
	
	var velocity = get_linear_velocity()
	
	if(colors.random(100) < DROP_PROBABILITY and drop_countdown < 0 ):
		ready = true
	
	if(get_global_pos().y > 400):
		set_linear_velocity(Vector2(velocity.x,-SPEED))
		return
	
func is_ready():
	return ready
	
func reload():
	ready = false
	drop_countdown = DROP_FREQUENCY;
