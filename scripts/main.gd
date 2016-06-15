
extends Node2D

var colors = preload("res://scripts/colors.gd")
var bricks = preload("res://scenes/brick.scn")
var drops = preload("res://scenes/black_drop.scn")

var brick_countdown
var drop_countdown

const BRICK_CREATION_PROBABILITY = 25
const BRICK_CREATION_FREQUENCY = 10
const DROP_FREQUENCY = 1;
const DROP_PROBABILITY = 50;

func _ready():
	brick_countdown = BRICK_CREATION_FREQUENCY
	drop_countdown = DROP_FREQUENCY;
	set_process(true)

func _process(delta):
	brick_countdown -= 1*delta
	drop_countdown -=1*delta
	
	
	#Se è finito il countdown, il nemico Rettangolo crea un mattone con una certa probabilità
	if(colors.random(100) < BRICK_CREATION_PROBABILITY && brick_countdown < 0):
		var enemies = get_tree().get_nodes_in_group("Rectangle")
		brick_countdown = BRICK_CREATION_FREQUENCY
		for enemy in enemies:
			_spawn_brick(enemy.get_global_pos())
	
	
	if(colors.random(100) < DROP_PROBABILITY and drop_countdown < 0 ):
		var enemies = get_tree().get_nodes_in_group("Sphere")
		for enemy in enemies:
			_spawn_drop(enemy.get_global_pos())

#Crea un nuovo mattone
func _spawn_brick(pos):	
	var brick_node = bricks.instance()
	brick_node.set_pos(pos)
	add_child(brick_node)
	
func _spawn_drop(pos):
	drop_countdown=DROP_FREQUENCY
	var new_drop = drops.instance()
	new_drop.set_pos(pos)
	add_child(new_drop)


