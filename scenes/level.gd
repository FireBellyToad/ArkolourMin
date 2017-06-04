
extends Node2D

var score_label 
var multiplier_label 
var lives_label
var fps_label

func _ready():	
	score_label = get_node( "ScoreLabel" )
	lives_label = get_node( "LivesLabel" )
	multiplier_label = get_node( "MultiplierLabel" )
	fps_label = get_node( "FPSLabel" )
	set_process( true )
	pass

func _process(delta):		
	score_label.set_text( "Score: " + str( get_node( "/root/main" ).score ) )
	lives_label.set_text( "Lives: " + str( get_node( "/root/main" ).bat_lives ) )
	multiplier_label.set_text( "Multiplier: " + str( get_node( main.BALL_NODE).get_ball_multiplier() ) )
	fps_label.set_text( "FPS: " + str( OS.get_frames_per_second() ) )
	
