extends KinematicBody2D

var colors = preload("res://scripts/colors.gd")
var bricks = preload("res://scenes/brick.scn")

const SPEED = 100
const WANDER_PROBABILITY = 10
const BRICK_CREATION_PROBABILITY = 25
const BRICK_CREATION_FREQUENCY = 10

var brick_countdown
var velocity 
var direction = Vector2(-1, -1)

func _ready():
	brick_countdown = BRICK_CREATION_FREQUENCY
	get_node("Collider").set_trigger(true)
	set_fixed_process(true)

func _fixed_process(delta):
	var velocity = direction * SPEED
	var motion = velocity * delta	
	move(motion)
	
	#Se il countdown è scaduto, c'è una certa probabilità che sia pronto a 
	#creare un Mattone
	brick_countdown -= 1*delta
	
	if(colors.random(100) < BRICK_CREATION_PROBABILITY && brick_countdown < 0):
		_spawn_brick()
	
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
	
func _spawn_brick():	
	var brick_node = bricks.instance()
	brick_node.set_pos(get_global_pos())
	get_parent().add_child(brick_node)
	reload()
	
func reload():
	brick_countdown = BRICK_CREATION_FREQUENCY
