extends Control

@onready var billy_pixel_silhoutte = $BillyButton/BillyPixelSilhoutte
@onready var billy_pixel = $BillyButton/BillyPixel
@onready var caroline_pixel_silhoutte = $CarolineButton/CarolinePixelSilhoutte
@onready var caroline_pixel = $CarolineButton/CarolinePixel

var gameplay = preload("res://scenes/gameplay.tscn")


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
	var gameplay_instance = gameplay.instantiate()
	gameplay_instance.playerSetter(true)
	get_tree().current_scene.queue_free()
	get_tree().root.add_child(gameplay_instance)
	get_tree().current_scene = gameplay_instance


func _on_caroline_button_pressed():
	var gameplay_instance = gameplay.instantiate()
	gameplay_instance.playerSetter(false)
	get_tree().current_scene.queue_free()
	get_tree().root.add_child(gameplay_instance)
	get_tree().current_scene = gameplay_instance
