#Colori universali
const COLOR_RED = 1
const COLOR_BLUE = 2
const COLOR_YELLOW = 4

#Colori speciali per i mattoni
const COLOR_RED_BLUE = 5
const COLOR_BLUE_YELLOW = 6
const COLOR_RED_YELLOW = 7
const COLOR_RED_BLUE_YELLOW = 8

const RED_MATERIAL = preload("res://materials/red_material.mtl")
const BLUE_MATERIAL = preload("res://materials/blue_material.mtl")
const YELLOW_MATERIAL = preload("res://materials/yellow_material.mtl") 

static func get_red_val():
	return COLOR_RED
	
static func get_blue_val():
	return COLOR_BLUE
	
static func get_yellow_val():
	return COLOR_YELLOW


static func get_red_blue_val():
	return COLOR_RED_BLUE
	
static func get_blue_yellow_val():
	return COLOR_BLUE_YELLOW
	
static func get_red_yellow_val():
	return COLOR_RED_YELLOW

static func get_red_blue_yellow_val():
	return COLOR_RED_BLUE_YELLOW


#Ottiene il corretto material a seconda del colore scelto
static func get_mat(color):
	
	if(color == COLOR_RED):
		return RED_MATERIAL
		
	if(color == COLOR_BLUE):
		return BLUE_MATERIAL
		
	if(color == COLOR_YELLOW):
		return YELLOW_MATERIAL

static func get_brick_mat(color,part):
	
	if(color == COLOR_RED or color == COLOR_BLUE or color == COLOR_YELLOW):
		return get_mat(color)
	
	if(color == COLOR_RED_BLUE):
		if(part == "LeftSide"):
			return RED_MATERIAL
		else:
			return BLUE_MATERIAL
	
	if(color == COLOR_RED_YELLOW):
		if(part == "LeftSide"):
			return RED_MATERIAL
		else:
			return YELLOW_MATERIAL
	
	if(color == COLOR_BLUE_YELLOW):
		if(part == "LeftSide"):
			return BLUE_MATERIAL
		else:
			return YELLOW_MATERIAL
	
	if(color == COLOR_RED_BLUE_YELLOW):
		if(part == "LeftSide"):
			return RED_MATERIAL
		else:
			if(part == "Middle"):
				return BLUE_MATERIAL
			else:
				return YELLOW_MATERIAL