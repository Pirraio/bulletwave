extends Control

var menu = preload("res://scenes/main.tscn")
@onready var hover_button_sound = $HoverSound

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_exit_to_menu_button_pressed():
	get_tree().change_scene_to_packed(menu)

func _on_exit_to_menu_button_mouse_entered():
	hover_button_sound.play()
