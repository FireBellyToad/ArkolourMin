
extends Node2D

var colors = preload("res://scripts/colors.gd")
var bricks = preload("res://scenes/brick.scn")
var drops = preload("res://scenes/black_drop.scn")


func _ready():
	set_process(true)

func _process(delta):
	
	
	#Se è finito il countdown, il nemico Rettangolo crea un mattone con una certa probabilità
		var enemies = get_tree().get_nodes_in_group("Rectangle")
		for enemy in enemies:
			if(enemy.is_ready()):
				_spawn_brick(enemy.get_global_pos())
				enemy.reload()
				
		
		var enemies = get_tree().get_nodes_in_group("Sphere")
		for enemy in enemies:
			if(enemy.is_ready()):
				_spawn_drop(enemy.get_global_pos())
				enemy.reload()

#Crea un nuovo mattone
func _spawn_brick(pos):	
	var brick_node = bricks.instance()
	brick_node.set_pos(pos)
	add_child(brick_node)
	
func _spawn_drop(pos):
	var new_drop = drops.instance()
	new_drop.set_pos(pos)
	add_child(new_drop)


