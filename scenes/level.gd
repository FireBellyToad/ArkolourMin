
extends Node2D

var score_label 

func _ready():	
	score_label = get_node("ScoreLabel")
	set_process(true)
	pass

func _process(delta):		
	score_label.set_text("Score: "+str(get_node("/root/main").score))

