
extends Node

var colors = preload("res://scripts/colors.gd")

var score setget ,get_score
var high_score

#Colori universali
const COLOR_RED = 1
const COLOR_BLUE = 2
const COLOR_YELLOW = 4

#Colori speciali per i mattoni
const COLOR_RED_BLUE = 3
const COLOR_BLUE_YELLOW = 6
const COLOR_RED_YELLOW = 5
const COLOR_RED_BLUE_YELLOW = 7

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
	
#Ottiene colore casuale
static func get_random_val():
	var rand = random(7)
	
	if(rand == COLOR_RED):
		return get_red_val()
	if(rand == COLOR_BLUE):
		return get_blue_val()
	if(rand == COLOR_YELLOW):
		return get_yellow_val()
	if(rand == COLOR_RED_BLUE):
		return get_red_blue_val()
	if(rand == COLOR_RED_YELLOW):
		return get_red_yellow_val()
	if(rand == COLOR_BLUE_YELLOW):
		return get_blue_yellow_val()
	if(rand == COLOR_RED_BLUE_YELLOW):
		return get_red_blue_yellow_val()
	
#Funzione per direzione casuale della palla
static func get_random_direction():
	var rand = random(6)
	
	if(rand == 1):
		return Vector2(-1,-1)
	if(rand == 2):
		return Vector2(0,-1)
	if(rand == 3):
		return Vector2(1,-1)
	if(rand == 4):
		return Vector2(1,1)
	if(rand == 5):
		return Vector2(0,1)
	if(rand == 6):
		return Vector2(-1,1)
	
#Funzione per tirare un dado di n facce
static func random(n):
	randomize()
	return 1+(randi()%n)

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
		if(part == "LeftSide" or part == "MiddleLeft" ):
			return RED_MATERIAL
		else:
			return BLUE_MATERIAL
	
	if(color == COLOR_RED_YELLOW):
		if(part == "LeftSide" or part == "MiddleLeft" ):
			return RED_MATERIAL
		else:
			return YELLOW_MATERIAL
	
	if(color == COLOR_BLUE_YELLOW):
		if(part == "LeftSide" or part == "MiddleLeft" ):
			return BLUE_MATERIAL
		else:
			return YELLOW_MATERIAL
	
	if(color == COLOR_RED_BLUE_YELLOW):
		if(part == "LeftSide" ):
			return RED_MATERIAL
		else:
			if(part == "MiddleLeft" or part == "MiddleRight" ):
				return BLUE_MATERIAL
			else:
				return YELLOW_MATERIAL

func _ready():
	score = 0
	high_score = 10000000
	
func add_score(value):
	score += value
	
func get_score():
	return score
	