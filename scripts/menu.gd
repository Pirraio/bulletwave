extends Control

@onready var hover_sound = $OptionsMenu/HoverSound
@onready var menu_music = $MenuMusic

var character_selection = preload("res://scenes/character_selection.tscn")
var how_to_play = preload("res://scenes/how_to_play.tscn")

func _ready():
	Input.set_custom_mouse_cursor(null)

func _on_play_button_pressed():
	add_child(character_selection.instantiate())
	#get_tree().change_scene_to_packed(character_selection)

func _on_how_to_play_button_pressed():
	add_child(how_to_play.instantiate())
	

func _on_play_button_mouse_entered():
	hover_sound.play()

func _on_how_to_play_button_mouse_entered():
	hover_sound.play()
