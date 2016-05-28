
extends StaticBody2D

var colors = preload("res://scripts/colors.gd")
var brick_color 
var brick_hardness

func _ready():
	_init_brick()


func _init_brick():
	_set_brick_color(colors.get_red_blue_yellow_val())
	brick_hardness = 2
	
func _set_brick_color(new_color):
	brick_color = new_color
	get_node("Viewport/Brick3D/LeftSide").set_material_override(colors.get_brick_mat(brick_color,"LeftSide"))
	get_node("Viewport/Brick3D/Middle").set_material_override(colors.get_brick_mat(brick_color,"Middle"))
	get_node("Viewport/Brick3D/RightSide").set_material_override(colors.get_brick_mat(brick_color,"RightSide"))
	
func get_brick_color():
	return brick_color