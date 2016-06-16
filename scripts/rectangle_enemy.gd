extends KinematicBody2D

var colors = preload("res://scripts/colors.gd")
var bricks = preload("res://scenes/brick.scn")	

const SPEED = 100
const WANDER_PROBABILITY = 10
const SPEED = 100
const BRICK_CREATION_PROBABILITY = 25
const BRICK_CREATION_FREQUENCY = 10

var brick_countdown
var velocity 
var direction = Vector2(-1, -1)

var ready setget ,is_ready

func _ready():
	brick_countdown = BRICK_CREATION_FREQUENCY
	get_node("Collider").set_trigger(true)
	set_fixed_process(true)

func _fixed_process(delta):
	var velocity = direction * SPEED
	var motion = velocity * delta	
	motion = move(velocity*delta)
	brick_countdown -= 1*delta
	
	if(colors.random(100) < BRICK_CREATION_PROBABILITY && brick_countdown < 0):
		ready = true
	
	if(colors.random(100) < WANDER_PROBABILITY ):
		if(colors.random(100) < 25):
			direction = Vector2(colors.random(3)-2,colors.random(3)-2)
	
	if(get_global_pos().y > 400):
		direction.y = -direction.y
		return
		
	if(get_global_pos().y < 25):
		direction.y = -direction.y
		return
	
	if(get_global_pos().x > 575):
		direction.x = -direction.x
		return	

	if(get_global_pos().x < 25):
		direction.x = -direction.x
		return	
	
func is_ready():
	return ready
	
func reload():
	ready = false
	brick_countdown = BRICK_CREATION_FREQUENCY
