
extends Node2D

var colors = preload("res://scripts/colors.gd")

var score
var high_score

func _ready():
	score = 0
	high_score = 10000000
