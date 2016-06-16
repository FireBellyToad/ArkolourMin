
extends KinematicBody2D

const ROTATE_SPEED = 5
const SPEED = 100
const WANDER_PROBABILITY = 10

var ball_node

func _ready():
	ball_node = get_tree().get_nodes_in_group("Ball")
	ball_node = ball_node[0]
	set_fixed_process(true)
	pass


func _fixed_process(delta):
	
	var ball_pos = ball_node.get_global_pos()
	
	var angle = get_angle_to(ball_pos)
	
	rotate(angle*delta*ROTATE_SPEED)	