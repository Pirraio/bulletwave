extends Control

@onready var billy_pixel_silhoutte = $BillyButton/BillyPixelSilhoutte
@onready var billy_pixel = $BillyButton/BillyPixel
@onready var caroline_pixel_silhoutte = $CarolineButton/CarolinePixelSilhoutte
@onready var caroline_pixel = $CarolineButton/CarolinePixel
@onready var hover_select_sound = $HoverSelectSound


var world = preload("res://scenes/world.tscn")

func _ready():
	billy_pixel_silhoutte.show()
	billy_pixel.hide()
	caroline_pixel_silhoutte.show()
	caroline_pixel.hide()

func _on_billy_button_mouse_entered():
	hover_select_sound.play()
	billy_pixel_silhoutte.hide()
	billy_pixel.show()

func _on_billy_button_mouse_exited():
	billy_pixel_silhoutte.show()
	billy_pixel.hide()


func _on_caroline_button_mouse_entered():
	hover_select_sound.play()
	caroline_pixel_silhoutte.hide()
	caroline_pixel.show()


func _on_caroline_button_mouse_exited():
	caroline_pixel_silhoutte.show()
	caroline_pixel.hide()


func _on_billy_button_pressed():
	Global.character = "billy"
	get_tree().change_scene_to_packed(world)


func _on_caroline_button_pressed():
	Global.character = "caroline"
	get_tree().change_scene_to_packed(world)
