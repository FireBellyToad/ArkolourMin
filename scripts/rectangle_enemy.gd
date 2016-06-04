extends KinematicBody2D

var colors = preload("res://scripts/colors.gd")
var bricks = preload("res://scenes/brick.scn")	

const SPEED = 100
const WANDER_PROBABILITY = 10
const SPEED = 100
var velocity 
var direction = Vector2(-1, -1)

func _ready():
	get_node("Collider").set_trigger(true)
	set_fixed_process(true)

func _fixed_process(delta):
	var velocity = direction * SPEED
	var motion = velocity * delta	
	motion = move(velocity*delta)
	
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
