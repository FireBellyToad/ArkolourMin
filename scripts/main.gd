
extends Node

const BALL_NODE = "Ball" 
const BAT_NODE = "Bat" 

const POWERUPS_NUMBER = 12 #Numero Massimo di poteri

const BONUS_M = 0 #Multicolor
const BONUS_L = 1 #Long
const BONUS_D = 2 #Distructive
const BONUS_S = 3 #Slow
const BONUS_1UP = 4 #1 extra life
const BONUS_5000 = 5 #Extra 5000 points
const BONUS_G = 6 #Gun

const MALUS_C = 7 #Change
const MALUS_F = 8 #Fast 
const MALUS_E = 9 #Goccia ( Evil )
const MALUS_H = 10 #Hollow 
const MALUS_I = 11 #Ink

var score setget ,get_score
var high_score
var difficulty 
var bat_lives

#Colori universali
const DIFFICULTY_NORMAL = 1
const DIFFICULTY_CLASSIC = 2

#Colori universali
const COLOR_RED = 1
const COLOR_BLUE = 2
const COLOR_YELLOW = 4

#Colori speciali per i mattoni
const COLOR_RED_BLUE = 3
const COLOR_BLUE_YELLOW = 6
const COLOR_RED_YELLOW = 5
const COLOR_RED_BLUE_YELLOW = 7

const RED_MATERIAL = preload(  "res://materials/red_material.mtl" )
const BLUE_MATERIAL = preload( "res://materials/blue_material.mtl" )
const YELLOW_MATERIAL = preload( "res://materials/yellow_material.mtl" ) 
const BLACK_MATERIAL = preload( "res://materials/black_material.mtl" )
const WHITE_MATERIAL = preload( "res://materials/white_material.mtl" ) 

const RED_COLOR = Color( 255, 0, 0, 1 )
const BLUE_COLOR = Color( 0, 0, 255, 1 )
const YELLOW_COLOR = Color( 215, 215, 0, 1 )
const WHITE_COLOR = Color( 255, 255, 255, 1 )

static func get_red_val( ):
	return COLOR_RED
	
static func get_blue_val( ):
	return COLOR_BLUE
	
static func get_yellow_val( ):
	return COLOR_YELLOW

static func get_red_blue_val( ):
	return COLOR_RED_BLUE
	
static func get_blue_yellow_val( ):
	return COLOR_BLUE_YELLOW
	
static func get_red_yellow_val( ):
	return COLOR_RED_YELLOW

static func get_red_blue_yellow_val( ):
	return COLOR_RED_BLUE_YELLOW
	
#Ottiene colore casuale
static func get_random_val( ):
	var rand = random( 7 )
	
	if( rand == COLOR_RED  ):
		return get_red_val()
	if( rand == COLOR_BLUE  ):
		return get_blue_val()
	if( rand == COLOR_YELLOW  ):
		return get_yellow_val()
	if( rand == COLOR_RED_BLUE  ):
		return get_red_blue_val()
	if( rand == COLOR_RED_YELLOW  ):
		return get_red_yellow_val()
	if( rand == COLOR_BLUE_YELLOW  ):
		return get_blue_yellow_val()
	if( rand == COLOR_RED_BLUE_YELLOW  ):
		return get_red_blue_yellow_val()
	
#Funzione per direzione casuale della palla
static func get_random_direction( ):
	var rand = random( 6 )
	
	if( rand == 1 ):
		return Vector2( -1, -1 )
	if( rand == 2 ):
		return Vector2( 0, -1 )
	if( rand == 3 ):
		return Vector2( 1, -1 )
	if( rand == 4 ):
		return Vector2( 1, 1 )
	if( rand == 5 ):
		return Vector2( 0, 1 )
	if( rand == 6 ):
		return Vector2( -1, 1 )
	
static func get_godot_color( color ):	
	if( color == COLOR_RED ):
		return RED_COLOR
		
	if( color == COLOR_BLUE ):
		return BLUE_COLOR
		
	if( color == COLOR_YELLOW ):
		return YELLOW_COLOR
		
#Funzione per tirare un dado di n facce
static func random( n ):
	randomize()
	return 1+( randi()%n )

#Ottiene il corretto material a seconda del colore scelto
static func get_mat( color ):
	
	if( color == COLOR_RED ):
		return RED_MATERIAL
		
	if( color == COLOR_BLUE ):
		return BLUE_MATERIAL
		
	if( color == COLOR_YELLOW ):
		return YELLOW_MATERIAL

#Ottiene il corretto material a seconda del colore e della parte scelto (per i Brick)
static func get_brick_mat( color,part ):
	
	if( color == COLOR_RED or color == COLOR_BLUE or color == COLOR_YELLOW ):
		return get_mat( color )
	
	if( color == COLOR_RED_BLUE ):
		if( part == "LeftSide" or part == "MiddleLeft" ):
			return RED_MATERIAL
		else:
			return BLUE_MATERIAL
	
	if( color == COLOR_RED_YELLOW ):
		if( part == "LeftSide" or part == "MiddleLeft" ):
			return RED_MATERIAL
		else:
			return YELLOW_MATERIAL
	
	if( color == COLOR_BLUE_YELLOW ):
		if( part == "LeftSide" or part == "MiddleLeft" ):
			return BLUE_MATERIAL
		else:
			return YELLOW_MATERIAL
	
	if( color == COLOR_RED_BLUE_YELLOW ):
		if( part == "LeftSide" ):
			return RED_MATERIAL
		else:
			if( part == "MiddleLeft" or part == "MiddleRight" ):
				return BLUE_MATERIAL
			else:
				return YELLOW_MATERIAL

#Ottiene il corretto material a seconda del valore del power up
static func get_power_up_mat( is_malus ):
	
	if( is_malus ):
		return BLACK_MATERIAL
	else:
		return WHITE_MATERIAL

#Inizializzo punteggi e difficoltà
func _ready():
	score = 0
	high_score = 10000000
	difficulty = DIFFICULTY_NORMAL
	
#Incremento punteggio
func add_score( value ):
	score += value
	
func get_score():
	return score
	
func is_normal_difficulty():
	return difficulty == DIFFICULTY_NORMAL
	