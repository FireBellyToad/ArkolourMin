const COLOR_RED = 1
const COLOR_BLUE = 2
const COLOR_YELLOW = 4

const RED_MATERIAL = preload("res://materials/red_material.mtl")
const BLUE_MATERIAL = preload("res://materials/blue_material.mtl")
const YELLOW_MATERIAL = preload("res://materials/yellow_material.mtl") 

static func get_red_val():
	return COLOR_RED
	
static func get_blue_val():
	return COLOR_BLUE
	
static func get_yellow_val():
	return COLOR_YELLOW


static func get_mat(color):
	
	if(color == COLOR_RED):
		return RED_MATERIAL
		
	if(color == COLOR_BLUE):
		return BLUE_MATERIAL
		
	if(color == COLOR_YELLOW):
		return YELLOW_MATERIAL