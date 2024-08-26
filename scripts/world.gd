extends Node2D


func _ready():
	var player_character = load("res://scenes/player_" + Global.character + ".tscn").instantiate()
	player_character.position = Vector2(640, 360)
	add_child(player_character)
	print(Global.character)
	pass


func _process(delta):
	pass
