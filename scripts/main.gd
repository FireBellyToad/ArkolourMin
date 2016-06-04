
extends Node2D

var colors = preload("res://scripts/colors.gd")
var bricks = preload("res://scenes/brick.scn")
var brick_countdown

const BRICK_CREATION_PROBABILITY = 25
const BRICK_CREATION_FREQUENCY = 10

func _ready():
	brick_countdown = BRICK_CREATION_FREQUENCY
	set_process(true)

func _process(delta):
	brick_countdown -= 1*delta
	
	#Se è finito il countdown, il nemico Rettangolo crea un mattone con una certa probabilità
	if(colors.random(100) < BRICK_CREATION_PROBABILITY && brick_countdown < 0):
		var enemies = get_tree().get_nodes_in_group("Rectangle")
		brick_countdown = BRICK_CREATION_FREQUENCY
		for enemy in enemies:
			_spawn_brick(enemy.get_global_pos())
			

#Crea un nuovo mattone
func _spawn_brick(pos):	
	var brick_node = bricks.instance(true)
	brick_node.set_pos(pos)
	add_child(brick_node)
