extends Control

var character_selection = preload("res://scenes/character_selection.tscn")

func _ready():
	Input.set_custom_mouse_cursor(null)

func _on_play_button_pressed():
	get_tree().change_scene_to_packed(character_selection)
