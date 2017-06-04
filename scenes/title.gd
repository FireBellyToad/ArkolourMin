
extends Control

func _ready():
	pass

#Init del livello di test
func _on_Button_pressed():
	get_node( "/root/main" ).score = 0;
	get_node( "/root/main" ).bat_lives = 3;
	get_tree().change_scene( "res://scenes/main.scn" )
	pass
