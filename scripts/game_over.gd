extends Control

@onready var hover_button_sound = $HoverButtonSound
var menu = preload("res://scenes/main.tscn")
var world = preload("res://scenes/world.tscn")

func _on_try_again_button_pressed():
	Global.health = 3
	get_tree().change_scene_to_packed(world)


func _on_try_again_button_mouse_entered():
	hover_button_sound.play()


func _on_exit_to_menu_button_pressed():
	get_tree().change_scene_to_packed(menu)

func _on_exit_to_menu_button_mouse_entered():
	hover_button_sound.play()
