extends Node

var health = 3
var character = "billy" #default character
var current_weapon = ""
var total_ammo = 12
var magazine = 6
var player = null
var enemyCount = 0

func start_game():
	health = 3
	current_weapon = ""
	total_ammo = 12
	magazine = 6

func reset_game_state():
	start_game()
