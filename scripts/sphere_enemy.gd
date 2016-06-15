
extends RigidBody2D

var colors = preload("res://scripts/colors.gd")

const SPEED = 100


func _ready():
	set_linear_velocity(Vector2(-SPEED,-SPEED))
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	
	var velocity = get_linear_velocity()
	
	if(get_global_pos().y > 400):
		set_linear_velocity(Vector2(velocity.x,-SPEED))
		return
	
