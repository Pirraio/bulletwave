extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	#var player_character = load("res://scenes/" + Global.character).instance() #ISSO NÃO FUNCIONOU
	#add_child(player_character)
	print(Global.character) #Está Printando corretamente
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
