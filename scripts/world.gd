extends Node2D
@onready var ammo_pickup_sound = $Ammo/PickupSound

@export var tile_map:TileMapLayer
@onready var player_spawn_point = $PlayerSpawnPoint

var menu = preload("res://scenes/main.tscn")

func _ready():
	var player_character = load("res://scenes/player_" + Global.character + ".tscn").instantiate()
	player_character.position = player_spawn_point.position
	add_child(player_character)
	Global.total_ammo = 12
	Global.magazine = 6
	Global.health = 3
	Global.enemyCount = 0
	



func _process(delta):
	if Global.enemyCount >= 10:
		Global.enemyCount = 0
		get_tree().change_scene_to_file("res://scenes/win.tscn")


func _on_lightsaber_body_entered(body):
	Global.current_weapon = "lightsaber"


func _on_ammo_body_entered(body):
	Global.total_ammo += 6
	if Global.magazine == 0:
		Global.magazine = Global.total_ammo
	print(Global.total_ammo)
	print(Global.magazine)
	ammo_pickup_sound.play()
	
	#get_node("Ammo").queue_free()
