extends Node2D

@onready var top_gear = $TopGear
@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	top_gear.play()
	animation_player.play("car_running")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_animation_player_animation_finished(anim_name):
	get_tree().change_scene_to_file("res://scenes/world.tscn")
