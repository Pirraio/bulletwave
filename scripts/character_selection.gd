extends Control

@onready var billy_pixel_silhoutte = $BillyButton/BillyPixelSilhoutte
@onready var billy_pixel = $BillyButton/BillyPixel
@onready var caroline_pixel_silhoutte = $CarolineButton/CarolinePixelSilhoutte
@onready var caroline_pixel = $CarolineButton/CarolinePixel

var billy_scene = preload("res://scenes/player_billy.tscn")
var caroline_scene = preload("res://scenes/player_caroline.tscn")

func _ready():
	billy_pixel_silhoutte.show()
	billy_pixel.hide()
	caroline_pixel_silhoutte.show()
	caroline_pixel.hide()

func _on_billy_button_mouse_entered():
	billy_pixel_silhoutte.hide()
	billy_pixel.show()

func _on_billy_button_mouse_exited():
	billy_pixel_silhoutte.show()
	billy_pixel.hide()


func _on_caroline_button_mouse_entered():
	caroline_pixel_silhoutte.hide()
	caroline_pixel.show()


func _on_caroline_button_mouse_exited():
	caroline_pixel_silhoutte.show()
	caroline_pixel.hide()


func _on_billy_button_pressed():
	get_tree().change_scene_to_packed(billy_scene)


func _on_caroline_button_pressed():
	get_tree().change_scene_to_packed(caroline_scene)
