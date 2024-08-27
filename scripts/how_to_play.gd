extends Control

@onready var hover_sound = $HoverSound

func _on_back_button_pressed():
	queue_free()


func _on_back_button_mouse_entered():
	hover_sound.play()
